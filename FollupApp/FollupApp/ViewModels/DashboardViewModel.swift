//
//  DashboardViewModel.swift
//  FollupApp
//
//  Created by ATMUCAK  on 17/05/26.
//

import Foundation

@Observable
class DashboardViewModel {
    // MARK: - Child ViewModels
    var jobVM = JobViewModel()
    var ticketVM = JiraTicketViewModel()
    
    // MARK: - Computed Summary
    /// Derives summary counts directly from jobs data — single source of truth
    var summaryItems: [StatusSummary] {
        FollowUpStatus.allCases.map { status in
            StatusSummary(
                status: status,
                count: jobVM.jobs.filter { $0.status == status }.count
            )
        }
    }
    
    // MARK: - Navigation Helpers
    
    /// Creates a TicketViewModel populated with jobs linked to the given ticket
    func ticketDetailVM(for ticket: JiraTicketItem) -> TicketViewModel {
        let vm = TicketViewModel()
        vm.jobs = jobVM.jobs.filter { $0.linkedTicket?.ticketKey == ticket.ticketKey }
        vm.selectedJobTitle = ticket.title
        return vm
    }
}
