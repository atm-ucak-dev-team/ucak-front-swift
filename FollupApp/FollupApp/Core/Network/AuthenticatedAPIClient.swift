//
//  AuthenticatedAPIClient.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//
import Foundation

// MARK: - AuthenticatedAPIClient
/// Authenticated HTTP client that auto-injects Bearer token from Keychain.
/// Automatically retries once on 401 after refreshing the token.
class AuthenticatedAPIClient: APIClient {
 
    // MARK: - Dependencies
    /// Injected KeychainManager — conforms to `TokenProvider` protocol.
    /// Pass your KeychainManager instance here; we don't create it internally.
    private let tokenProvider: any TokenProvider
 
    // MARK: - Init
    init(baseURL: String, tokenProvider: any TokenProvider) {
        self.tokenProvider = tokenProvider
        super.init(baseURL: baseURL)
    }
 
    // MARK: - Authenticated Request
    /// Same signature as `APIClient.request`, but auto-injects `Authorization: Bearer <token>`.
    /// Retries once if a 401 is received (token may have just been refreshed by KeychainManager).
    @discardableResult
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .GET,
        body: (any Encodable)? = nil,
        additionalHeaders: [String: String] = [:]
    ) async throws -> T {
 
        // 1. Get valid access token from Keychain
        guard let token = try await tokenProvider.getValidAccessToken() else {
            throw APIError.noAccessToken
        }
 
        // 2. Inject Bearer token
        var headers = additionalHeaders
        headers["X-Jira-Access-Token"] = token
        headers["X-User-Cloud-ID"] = KeychainManager.shared.getCloudId()
        headers["X-User-Dummy-Id"] = "dummy"

        // 3. Perform request (with one 401 retry)
        do {
            return try await super.request(
                endpoint: endpoint,
                method: method,
                body: body,
                headers: headers
            )
        } catch APIError.unauthorized {
            // Token might be stale — ask provider to refresh, then retry once
            guard let refreshedToken = try await tokenProvider.getValidAccessToken() else {
                throw APIError.unauthorized
            }
            headers["X-Jira-Access-Token"] = refreshedToken
            headers["X-User-Cloud-ID"] = KeychainManager.shared.getCloudId()
            headers["X-User-Dummy-Id"] = "dummy"
            return try await super.request(
                endpoint: endpoint,
                method: method,
                body: body,
                headers: headers
            )
        }
    }
}
