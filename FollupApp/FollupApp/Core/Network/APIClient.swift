//
//  APIClient.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import Foundation

// MARK: - APIResponse Wrapper
/// Matches your API shape: { data: T, message: String, status: Int }
struct APIResponse<T: Decodable>: Decodable {
    let data: T
    let message: String
    let status: Int
}

// MARK: - APIClient
/// Base HTTP client for public (unauthenticated) endpoints.
/// Subclass or inject for specific use cases.
class APIClient {

    // MARK: - Config
    let baseURL: String
    private let session: URLSession
    private let decoder: JSONDecoder

    // MARK: - Init
    init(
        baseURL: String,
        session: URLSession = .shared,
        decoder: JSONDecoder = {
            let d = JSONDecoder()
            d.keyDecodingStrategy = .convertFromSnakeCase
            d.dateDecodingStrategy = .iso8601
            return d
        }()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }

    // MARK: - Core Request
    /// Generic request method. Returns decoded `T` directly (unwrapped from APIResponse).
    ///
    /// - Parameters:
    ///   - endpoint: Path like "/users/me"
    ///   - method: HTTPMethod (.GET, .POST, etc.)
    ///   - body: Optional Encodable payload
    ///   - headers: Additional headers to merge
    /// - Returns: Decoded `T`
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .GET,
        body: (any Encodable)? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        // 1. Build URL
        guard let url = URL(string: baseURL + endpoint) else {
            throw APIError.invalidURL
        }

        // 2. Build URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        // Merge additional headers
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

        // 3. Encode body if present
        if let body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }

        // 4. Fire request
        let (data, response) = try await session.data(for: urlRequest)

        // 5. Validate HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            break // success
        case 401:
            throw APIError.unauthorized
        default:
            throw APIError.httpError(statusCode: httpResponse.statusCode, message: "Failed to fetch from server")
        }

        // 6. Decode wrapped response, return only `data`
        do {
            let wrapped = try decoder.decode(T.self, from: data)
            return wrapped
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
