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
    
    private let maxColumnDisplayCount = 2
    
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

    var ticketColumn: [JiraTicketItem] {
        Array(tickets.prefix(maxColumnDisplayCount))
    }

    var ticketRows: [[JiraTicketItem]] {
        guard !tickets.isEmpty else { return [] }


        var rows: [[JiraTicketItem]] = []

        rows.reserveCapacity((tickets.count + 1) / 2)


        var index = 0
        while index < tickets.count {
            let end = min(index + 2, tickets.count)

            rows.append(Array(tickets[index..<end]))

            index += 2
        }

        return rows
    }
}
