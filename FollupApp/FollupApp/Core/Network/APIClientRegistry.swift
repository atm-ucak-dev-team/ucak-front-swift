//
//  APIClientRegistry.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import Foundation

enum APIClientRegistry {
    static let baseUrl: String = {
        let raw = Bundle.main.object(forInfoDictionaryKey: "BackendBaseURL") as? String ?? ""
        if raw.isEmpty || raw.contains("$(") {
            return "https://follup-be.onrender.com"
        }
        return raw
    }()
    
    static let general = APIClient(baseURL: baseUrl)
    static let authenticated = AuthenticatedAPIClient(baseURL: baseUrl, tokenProvider: KeychainManager.shared)
}
    