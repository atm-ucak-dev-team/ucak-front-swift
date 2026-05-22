//
//  APIClientRegistry.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import Foundation

enum APIClientRegistry {
    static let general = APIClient(baseURL: "https://challenge2.test-bomsiwor.my.id")
    static let authenticated = AuthenticatedAPIClient(baseURL: "https://challenge2.test-bomsiwor.my.id", tokenProvider: KeychainManager.shared)
}
