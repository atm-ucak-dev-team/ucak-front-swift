//
//  FollowUp+Display.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 25/05/26.
//

import Foundation

extension FollowUp {
    // MARK: - Shared Date Formatter
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d/M/yyyy"
        return formatter
    }()
    
    // MARK: - Display Helpers
    
    /// Returns context-aware date info based on follow-up status
    var dateInfoText: String {
        switch status {
        case .expired:
            return "Last email: \(Self.dateFormatter.string(from: lastFollowUpDate))"
        case .ongoing, .replied:
            return "Next follow-up: \(Self.dateFormatter.string(from: nextFollowUpDate))"
        }
    }
    
    /// Returns linked Jira ticket key, or nil if no ticket is linked
    var ticketInfoText: String? {
        guard let ticket = linkedTicket else { return nil }
        return "Jira Ticket: \(ticket.ticketKey)"
    }
}
