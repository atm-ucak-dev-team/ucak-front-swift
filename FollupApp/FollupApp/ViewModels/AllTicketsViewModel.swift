//
//  AllTicketsViewModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 25/05/26.
//

import Foundation

@Observable
class AllTicketsViewModel {
    var tickets: [JiraTicketItem] = []
    var searchText: String = ""
    var selectedFilter: JiraStatus? = nil
    
    // MARK: - Filtered Tickets
    var filteredTickets: [JiraTicketItem] {
        var result = tickets
        
        if let filter = selectedFilter {
            result = result.filter { $0.status == filter }
        }
        
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.ticketKey.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return result
    }
    
    // MARK: - Child ViewModel Helper
    private var _ticketVM = JiraTicketViewModel()
    
    var ticketViewModel: JiraTicketViewModel {
        _ticketVM.tickets = filteredTickets
        _ticketVM.showAll = true
        return _ticketVM
    }
    
    // MARK: - Computed Counts
    var todoCount: Int {
        tickets.filter { $0.status == .todo }.count
    }
    
    var inProgressCount: Int {
        tickets.filter { $0.status == .inprogress }.count
    }
    
    var doneCount: Int {
        tickets.filter { $0.status == .done }.count
    }
}
