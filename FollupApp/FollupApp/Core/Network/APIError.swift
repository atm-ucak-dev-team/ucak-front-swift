//
//  APIError.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import Foundation

// MARK: - APIError
enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, message: String?)
    case decodingError(Error)
    case unauthorized
    case noAccessToken
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:               return "Invalid URL."
        case .invalidResponse:          return "Invalid server response."
        case .httpError(let code, let msg): return "HTTP \(code): \(msg ?? "Unknown error")"
        case .decodingError(let err):   return "Decoding failed: \(err.localizedDescription)"
        case .unauthorized:             return "Unauthorized. Please log in again."
        case .noAccessToken:            return "No access token found in Keychain."
        case .unknown(let err):         return "Unexpected error: \(err.localizedDescription)"
        }
    }
}
