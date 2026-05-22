//
//  APIClientRegistry.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import Foundation

enum APIClientRegistry {
    static let baseUrl: String = Bundle.main.object(forInfoDictionaryKey: "BackendBaseURL") as? String ?? "http://localhost:3000"
    
    static let general = APIClient(baseURL: baseUrl)
    static let authenticated = AuthenticatedAPIClient(baseURL: baseUrl, tokenProvider: KeychainManager.shared)
}
