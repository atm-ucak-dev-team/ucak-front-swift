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
    var needsRefresh: Bool = false
    private var hasLoaded: Bool = false
    private var hasLoadedStats: Bool = false
    private var hasLoadedTickets: Bool = false
    private let dummyUserId = "cihuy"

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
            enrichTicketTitles()
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
            enrichTicketTitles()
        } catch {
            if errorMessage == nil {
                errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
            }
            hasLoadedTickets = false
        }
    }

    /// Client-side enrichment to match raw ticket IDs (e.g. "10101") with active follow-ups,
    /// extracting and displaying the real clean title (e.g. "Project Charter Follup").
    private func enrichTicketTitles() {
        for index in 0..<ticketVM.tickets.count {
            let ticket = ticketVM.tickets[index]
            if let matchingJob = jobVM.jobs.first(where: { $0.linkedTicket?.ticketKey == ticket.ticketKey }) {
                if ticket.title == ticket.ticketKey || ticket.title.isEmpty {
                    let cleanTitle = cleanTitleFromSubject(matchingJob.title, key: ticket.ticketKey)
                    
                    ticketVM.tickets[index] = JiraTicketItem(
                        id: ticket.id,
                        ticketKey: ticket.ticketKey,
                        title: cleanTitle,
                        iconName: ticket.iconName,
                        status: ticket.status,
                        stakeholder: ticket.stakeholder
                    )
                }
            }
        }
    }
    
    private func cleanTitleFromSubject(_ subject: String, key: String) -> String {
        var title = subject
        // 1. Remove bracketed key prefix: e.g. "[ADAC2-5] " or "[10101] "
        if let range = title.range(of: "]") {
            title = String(title[range.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        // 2. Remove " - Follow-Up" or " - Follow-ups" suffix
        if let range = title.range(of: " - Follow", options: .backwards) {
            title = String(title[..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return title.isEmpty ? subject : title
    }

    @MainActor
    func refreshAll() async {
        hasLoaded = false
        hasLoadedStats = false
        hasLoadedTickets = false
        errorMessage = nil

        async let loadFollowUps = fetchFollowUps()
        async let loadStats = fetchStatistics()
        async let loadTickets = fetchTickets()
        _ = await (loadFollowUps, loadStats, loadTickets)
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
    
    /// Creates a JiraTicketCardViewModel for the ChooseJiraTicketView.
    /// The view fetches its own tickets from the Jira API on appear.
    func chooseJiraTicketVM() -> JiraTicketCardViewModel {
        return JiraTicketCardViewModel()
    }
}
