//
//  CreateFollowUpResponse.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 28/05/26.
//

import Foundation

/// Response body from POST /api/v1/followups (201 Created)
/// The decoder uses `.convertFromSnakeCase` which auto-converts
/// snake_case JSON keys (e.g. `jira_ticket_id` → `jiraTicketId`).
/// CamelCase JSON keys (e.g. `jiraTicketTitle`) pass through unchanged.
struct CreateFollowUpResponse: Decodable {
    let id: String
    let jiraTicketId: String
    let jiraTicketKey: String
    let jiraTicketTitle: String
    let jiraStakeholder: String
    let jiraTicketStatus: String
    let userId: String
    let to: String
    let cc: String
    let subject: String
    let emailBody: String
    let startDateTime: String
    let expireDateTime: String
    let frequency: String
    let `repeat`: Int
    let followupConfirmation: Bool
    let status: String
    let executionCount: Int
    let lastRunAt: String?
    let createdAt: String
}
