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
    private var hasLoadedStats: Bool = false
    private var hasLoadedTickets: Bool = false
    private let dummyUserId = "test-user-123"

    private var summaryCounts: [FollowUpStatus: Int] = [:]
    
    // Mock Data only appear in debug mode not in production
    init() {
        #if DEBUG
        MockData.populateDashboard(self)
        summaryCounts = Self.summaryCounts(from: jobVM.jobs)
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
                headers: ["X-User-Dummy-Id": dummyUserId]
            )
            let jobs = items.compactMap { $0.toFollowUp() }
            jobVM.jobs = jobs
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
            hasLoaded = false
        }
    }

    @MainActor
    func fetchStatistics() async {
        guard !hasLoadedStats else { return }
        hasLoadedStats = true

        do {
            let response: FollowUpStatisticResponse = try await client.request(
                endpoint: "/api/v1/statistic",
                headers: ["X-User-Dummy-Id": dummyUserId]
            )
            summaryCounts = [
                .replied: response.replied,
                .ongoing: response.ongoing,
                .expired: response.expired
            ]
        } catch {
            if errorMessage == nil {
                errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
            }
            hasLoadedStats = false
        }
    }

    @MainActor
    func fetchTickets() async {
        guard !hasLoadedTickets else { return }
        hasLoadedTickets = true

        do {
            let items: [JiraTicketAPIItem] = try await client.request(
                endpoint: "/api/v1/tickets",
                headers: ["X-User-Dummy-Id": dummyUserId]
            )
            ticketVM.tickets = items.map { $0.toJiraTicket() }
        } catch {
            if errorMessage == nil {
                errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
            }
            hasLoadedTickets = false
        }
    }
    
    // MARK: - Computed Summary
    /// Derives summary counts directly from jobs data — single source of truth
    var summaryItems: [StatusSummary] {
        FollowUpStatus.allCases.map { status in
            StatusSummary(status: status, count: summaryCounts[status, default: 0])
        }
    }

    private static func summaryCounts(from jobs: [FollowUp]) -> [FollowUpStatus: Int] {
        var counts: [FollowUpStatus: Int] = [:]
        for status in FollowUpStatus.allCases {
            counts[status] = jobs.filter { $0.status == status }.count
        }
        return counts
    }
    
    // MARK: - Navigation Helpers
    
    /// Creates a TicketViewModel populated with jobs linked to the given ticket
    func ticketDetailVM(for ticket: JiraTicketItem) -> TicketViewModel {
        let vm = TicketViewModel()
//        vm.jobs = jobVM.jobs.filter { $0.linkedTicket?.ticketKey == ticket.ticketKey }
        vm.ticketId = ticket.ticketKey         //edited by eileen
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
