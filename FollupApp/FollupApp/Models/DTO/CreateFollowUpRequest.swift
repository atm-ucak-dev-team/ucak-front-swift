//
//  CreateFollowUpRequest.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 28/05/26.
//

import Foundation

/// Request body for POST /api/v1/followups
struct CreateFollowUpRequest: Encodable {
    let jiraTicketId: String
    let jiraTicketKey: String
    let jiraTicketTitle: String
    let jiraStakeholder: String
    let jiraTicketStatus: String
    let to: String
    let cc: String
    let subject: String
    let emailBody: String
    let startDateTime: String
    let expireDateTime: String
    let frequency: String
    let `repeat`: Int
    let followupConfirmation: Bool
}
