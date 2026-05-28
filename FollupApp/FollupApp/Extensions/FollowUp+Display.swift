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
            return "Last email: \(Self.format(date: lastFollowUpDate))"
        case .ongoing:
            return "Next follow-up: \(Self.format(date: nextFollowUpDate))"
        case .replied:
            return "Replied at: \(Self.format(date: repliedAt))"
        }
    }
    
    /// Returns linked Jira ticket title, or nil if no ticket is linked
    var ticketInfoText: String? {
        guard let ticket = linkedTicket else { return nil }
        let displayValue = (ticket.title == ticket.ticketKey || ticket.title.isEmpty) ? ticket.ticketKey : ticket.title
        return "Jira Ticket: \(displayValue)"
    }

    private static func format(date: Date?) -> String {
        guard let date else { return "-" }
        return dateFormatter.string(from: date)
    }
}
