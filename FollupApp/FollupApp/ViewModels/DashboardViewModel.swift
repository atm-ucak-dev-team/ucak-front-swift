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

    private let client: APIClient = APIClientRegistry.general
    var isLoading: Bool = false
    var errorMessage: String?
    private var hasLoaded: Bool = false
    
    // Mock Data only appear in debug mode not in production
    init() {
        #if DEBUG
        MockData.populateDashboard(self)
        #endif
    }

    @MainActor
    func fetchFollowUps() async {
        guard !hasLoaded else { return }
        hasLoaded = true
        isLoading = true
        defer { isLoading = false }

        do {
            let items: [FollowUpAPIItem] = try await client.request(
                endpoint: "/api/v1/followup",
                headers: ["X-User-Dummy-Id": "test-user-123"]
            )
            let jobs = items.compactMap { $0.toFollowUp() }
            jobVM.jobs = jobs
            ticketVM.tickets = Self.buildTickets(from: items)
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
            hasLoaded = false
        }
    }

    private static func buildTickets(from items: [FollowUpAPIItem]) -> [JiraTicketItem] {
        var seen = Set<String>()
        var result: [JiraTicketItem] = []

        for item in items {
            guard !seen.contains(item.jiraTicketId) else { continue }
            seen.insert(item.jiraTicketId)
            result.append(
                JiraTicketItem(
                    ticketKey: item.jiraTicketId,
                    title: item.jiraTicketId,
                    iconName: "circle.circle.fill"
                )
            )
        }

        return result
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
