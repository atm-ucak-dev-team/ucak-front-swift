//
//  ConnectToJiraViewModel.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import Foundation
import Observation

@Observable
class ConnectToJiraViewModel {
    // State UI
    var isAuthLoading = false
    var errorMessage: String?
    
    // Data Token & Debug info
    var authToken: String?
    var debugRefresh: String?
    var debugExpiredAt: String?
    var debugCloudId: String?
    
    private let scheme = "follupapp"
    private let authService = JiraAuthenticationService()
    
    init() {
        // Load token on initialization
        refreshLocalTokenState()
    }
    
    func connectJira() async {
        isAuthLoading = true
        errorMessage = nil
        
        do {
            // MARK: Uncomment
            // let initAuthURL = try await getAuthUrl()
            // let targetURL = initAuthURL.connectUrl
            
            let targetURL = "\(APIClientRegistry.baseUrl)/auth/jira/dummy-callback"
            
            _ = try await authService.login(with: targetURL, callbackScheme: scheme)
            
        } catch JiraAuthError.userCancelled {
            errorMessage = "Oh no! Do not cancel the operation :("
        } catch {
            errorMessage = "Oh no! We fail to connect you, try again, sorry!"
        }
        
        isAuthLoading = false
        refreshLocalTokenState()
    }
    
    private func getAuthUrl() async throws -> JiraAuthURLResponse {
        let (data, _) = try await URLSession.shared.data(from: URL(string:"\(APIClientRegistry.baseUrl)/auth/jira/connect")!)
        return try JSONDecoder().decode(JiraAuthURLResponse.self, from: data)
    }
    
    private func refreshLocalTokenState() {
        authToken = KeychainManager.shared.getAccessToken()
        debugRefresh = KeychainManager.shared.getRefreshToken()
        debugExpiredAt = KeychainManager.shared.getExpirationDate()?.ISO8601Format()
        debugCloudId = KeychainManager.shared.getCloudId()
    }
}
