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
    
    // Mock Data only appear in debug mode not in production
    init() {
        #if DEBUG
        MockData.populateDashboard(self)
        #endif
    }
    
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
    
    /// Creates an AllJobsViewModel populated with all dashboard jobs
    func allJobsVM() -> AllJobsViewModel {
        let vm = AllJobsViewModel()
        vm.jobs = jobVM.jobs
        return vm
    }
    
    /// Creates an AllTicketsViewModel populated with all dashboard tickets
    func allTicketsVM() -> AllTicketsViewModel {
        let vm = AllTicketsViewModel()
        vm.tickets = ticketVM.tickets
        return vm
    }
    
    /// Creates a JiraTicketCardViewModel populated with all dashboard tickets
    func chooseJiraTicketVM() -> JiraTicketCardViewModel {
        let vm = JiraTicketCardViewModel()
        vm.tickets = ticketVM.tickets
        return vm
    }
}
