//
//  JiraTicketCardViewModel.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 24/05/26.
//

import Foundation

@Observable
class JiraTicketCardViewModel {
    var tickets: [JiraTicketItem] = []
    var isLoading = false
    var errorMessage: String?
    var searchText: String = ""
    
    // MARK: - Computed Properties
    
    var isEmpty: Bool {
        tickets.isEmpty
    }

    var ticketCount: Int {
        tickets.count
    }
    
    var hasTickets: Bool {
        ticketCount > 0
    }
    
    // MARK: - API Fetch
    
    /// Fetches Jira issues from the backend API.
    /// - Parameters:
    ///   - search: Optional search query to filter tickets
    ///   - limit: Maximum number of results (default: 10)
    @MainActor
    func fetchJiraIssues(search: String = "", limit: Int = 10) async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Build query parameters
            var endpoint = "/api/v1/jira/issues?limit=\(limit)"
            if !search.isEmpty {
                let encoded = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? search
                endpoint += "&search=\(encoded)"
            }
            
            // Use the authenticated API client which auto-injects Jira tokens
            let response: [ChooseTicketResponseItem] = try await APIClientRegistry.authenticated.request(
                endpoint: endpoint,
                additionalHeaders: [:]
            )
            
            // Map DTO to domain model
            tickets = response.map { $0.toJiraTicketItem() }
            
        } catch {
            errorMessage = "Failed to load tickets. Pull to retry."
            print("❌ [JiraTicketCardViewModel] fetchJiraIssues error: \(error)")
        }
        
        isLoading = false
    }
}
