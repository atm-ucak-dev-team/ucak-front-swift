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
}
