//
//  JiraTicketViewModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 22/05/26.
//

import Foundation

@Observable
class JiraTicketViewModel {
    var tickets: [JiraTicketItem] = []
    var showAll: Bool = false
    
    private let maxDisplayCount = 3
    
    // MARK: - Computed Properties
    
    var isEmpty: Bool {
        tickets.isEmpty
    }
    
    var displayedTickets: [JiraTicketItem] {
        showAll ? tickets : Array(tickets.prefix(maxDisplayCount))
    }
    
    
    func isLastItem(_ index: Int) -> Bool {
        index >= displayedTickets.count - 1
    }
}
