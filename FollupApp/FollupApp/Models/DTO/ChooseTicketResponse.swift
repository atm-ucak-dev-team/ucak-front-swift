//
//  ChooseTicketResponse.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 28/05/26.
//

import Foundation

/// DTO matching the JSON array items from GET /api/v1/jira/issues
/// Example:
/// {
///   "id": "10002",
///   "key": "ADAC2-2",
///   "url": "https://...",
///   "ticketTitle": "[BE][Enhancement] Add register passkey",
///   "stakeholder": "Radit",
///   "status": "To Do",
///   "statusColor": "blue-gray"
/// }
struct ChooseTicketResponseItem: Decodable {
    let id: String
    let key: String
    let url: String
    let ticketTitle: String
    let stakeholder: String
    let status: String
    let statusColor: String
}

// MARK: - Mapping to Domain Model
extension ChooseTicketResponseItem {
    /// Convert API response item to the app's `JiraTicketItem` domain model
    func toJiraTicketItem() -> JiraTicketItem {
        return JiraTicketItem(
            id: id,
            ticketKey: key,
            title: ticketTitle,
            iconName: "circle.circle.fill",
            status: JiraStatus.from(apiStatus: status)
        )
    }
}
