//
//  KeychainManager.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import Foundation

// MARK: - TokenProvider Protocol
/// Abstracts the KeychainManager so `AuthenticatedAPIClient` stays testable.
/// Your KeychainManager just needs to conform to this.
protocol TokenProvider {
    /// Returns a valid (possibly refreshed) access token, or nil if not logged in.
    func getValidAccessToken() async throws -> String?
}

class KeychainManager {

    // MARK: - Singleton
    static let shared = KeychainManager()
    private init() {}

    // MARK: - Keys
    private enum Key: String {
        case accessToken = "com.app.auth.accessToken"
        case refreshToken = "com.app.auth.refreshToken"
        case expiredAt = "com.app.auth.expiredAt"
        case expirationTime = "com.app.auth.expirationTime"
        case cloudId = "com.app.auth.cloudId"
    }

    // MARK: - Refresh Buffer
    private let refreshBuffer: Int = 5 * 60

    // MARK: - Save
    func save(_ token: Token) {
        saveToKeychain(token.accessToken, forKey: Key.accessToken.rawValue)
        saveToKeychain(token.refreshToken, forKey: Key.refreshToken.rawValue)
        saveToKeychain(token.cloudId, forKey: Key.cloudId.rawValue)

        // Simpan langsung Unix Timestamp sebagai String
        saveToKeychain(String(token.expiresAt), forKey: Key.expiredAt.rawValue) // Store as timestamp
    }

    // MARK: - Get
    func getAccessToken() -> String? {
        return getFromKeychain(forKey: .accessToken)
    }

    func getRefreshToken() -> String? {
        return getFromKeychain(forKey: .refreshToken)
    }

    func getCloudId() -> String? {
        return getFromKeychain(forKey: .cloudId)
    }

    func getExpirationDate() -> Date? {
        guard let raw = getFromKeychain(forKey: .expiredAt),
            let interval = Double(raw)

        else { return nil }
        
        return Date(timeIntervalSince1970: interval)
    }

    // MARK: - Clear (Logout)
    func clearTokens() {
        deleteFromKeychain(forKey: .accessToken)
        deleteFromKeychain(forKey: .refreshToken)
        deleteFromKeychain(forKey: .cloudId)
        deleteFromKeychain(forKey: .expiredAt)
    }

    // MARK: - Private Helpers
    private func saveToKeychain(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else { return }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    private func getFromKeychain(forKey key: KeychainManager.Key) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        guard let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    private func deleteFromKeychain(forKey key: KeychainManager.Key) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
        ]
        SecItemDelete(query as CFDictionary)
    }
}

// MARK: - TokenProvider Conformance
extension KeychainManager: TokenProvider {

    /// Return valid access token
    /// Automatically refresh token if expired
    func getValidAccessToken() async throws -> String? {
        // Check for access token
        guard let accessToken = getAccessToken() else {
            throw KeychainError.notFound
        }
        guard let expirationTime = getExpirationDate() else {
            throw KeychainError.notFound
        }

        // Check if token is still valid
        let now = Int(Date().timeIntervalSince1970)
        let shouldRefresh = (Int(expirationTime.timeIntervalSince1970) - refreshBuffer) < now

        guard shouldRefresh else {
            // Token still lvalid
            return accessToken
        }

        // 3. Token expired, refresh token
        let newTokens = try await refreshTokens()
        return newTokens.accessToken
    }
}

// MARK: - Private: Refresh Logic
private extension KeychainManager {
 
    /// Call POST to refresh token
    @discardableResult
    func refreshTokens() async throws -> TokenResponse {
        // 1. Ambil refresh token dari Keychain
        guard let refreshToken = getRefreshToken() else {
            throw KeychainError.noRefreshToken
        }
 
        // 2. Construct request
        guard let url = URL(string: "https://challenge2.test-bomsiwor.my.id/auth/refresh") else {
            throw KeychainError.refreshFailed("Invalid URL")
        }
 
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        let body = ["refreshToken": refreshToken]
        request.httpBody = try JSONEncoder().encode(body)
 
        // 3. Fire request
        let (data, response) = try await URLSession.shared.data(for: request)
 
        guard let httpResponse = response as? HTTPURLResponse else {
            throw KeychainError.refreshFailed("Invalid response")
        }
 
        guard (200...299).contains(httpResponse.statusCode) else {
            throw KeychainError.tokenExpiredAndRefreshFailed
        }
 
        // 4. Decode response
        let decoder = JSONDecoder()
 
        let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
        
        // Setup formatter for expires At
        let isoFormatter = ISO8601DateFormatter()
        let expiredTimestamp: Double
        if let date = isoFormatter.date(from: tokenResponse.expiredAt) {
            expiredTimestamp = date.timeIntervalSince1970
        } else {
            throw KeychainError.refreshFailed("Invalid response")
        }
 
        // 5. Store new token 
        saveToKeychain(tokenResponse.accessToken, forKey: KeychainManager.Key.accessToken.rawValue)
        saveToKeychain(tokenResponse.refreshToken, forKey: KeychainManager.Key.refreshToken.rawValue)
        saveToKeychain(String(expiredTimestamp), forKey: KeychainManager.Key.expiredAt.rawValue)

        return tokenResponse
    }
}

enum KeychainError: LocalizedError {
    case saveFailed(OSStatus)
    case readFailed(OSStatus)
    case deleteFailed(OSStatus)
    case notFound
    case noRefreshToken
    case refreshFailed(String)
    case tokenExpiredAndRefreshFailed
 
    var errorDescription: String? {
        switch self {
        case .saveFailed(let s):         return "Keychain save failed: \(s)"
        case .readFailed(let s):         return "Keychain read failed: \(s)"
        case .deleteFailed(let s):       return "Keychain delete failed: \(s)"
        case .notFound:                  return "Token not found in Keychain."
        case .noRefreshToken:            return "No refresh token stored."
        case .refreshFailed(let msg):    return "Token refresh failed: \(msg)"
        case .tokenExpiredAndRefreshFailed: return "Session expired. Please log in again."
        }
    }
}
