//
//  TicketViewModel.swift
//  FollupApp
//
//  Created by Eileen Anindya on 22/05/26.
//

import Foundation

@Observable
class TicketViewModel{
    var jobs: [FollowUp] = []
    var searchText: String = ""
    var selectedFilter: FollowUpStatus? = nil
    var selectedJobTitle: String? = nil
    var ticketId: String = ""
    
    private let client: APIClient = APIClientRegistry.general
    private let dummyUserId = "test-user-123"
    var isLoading: Bool = false
    var errorMessage: String? = nil
    private var hasLoadedJobs: Bool = false
    private var hasLoadedSummary: Bool = false
    
    private var summaryCounts: [FollowUpStatus: Int] = [:]
        
    // MARK: - Fetch Jobs per Ticket
    @MainActor
    func fetchFollowUps() async {
        print("Fetching followups for ticket: \(ticketId)")

        guard !hasLoadedJobs else { return }
        hasLoadedJobs = true
        isLoading = true
        defer { isLoading = false }
        
        do {
            let items: [FollowUpAPIItem] = try await client.request(
                endpoint: "/api/v1/\(ticketId)/followups",
                headers: ["X-User-Dummy-Id": dummyUserId]
            )
            jobs = items.compactMap { $0.toFollowUp() }
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
            hasLoadedJobs = false
        }
        print("Fetched \(jobs.count) jobs")
    }
    
    // MARK: - Fetch Summary per Ticket
    @MainActor
    func fetchSummary() async {
        print("Fetching summary for ticket: \(ticketId)")
        guard !hasLoadedSummary else { return }
        hasLoadedSummary = true
        
        do {
            let response: TicketSummaryResponse = try await client.request(
                endpoint: "/api/v1/\(ticketId)/summary",
                headers: ["X-User-Dummy-Id": dummyUserId]
            )
            summaryCounts = [
                .replied: response.replied,
                .ongoing: response.ongoing,
                .expired: response.expired
            ]
            if selectedJobTitle == nil || selectedJobTitle?.isEmpty == true {
                selectedJobTitle = response.jiraTitle.isEmpty ? ticketId : response.jiraTitle
            }
        } catch {
            if errorMessage == nil {
                errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
            }
            hasLoadedSummary = false
        }
        print("Summary: \(summaryCounts)")
    }
    
    // MARK: - Filtered Jobs
    var filteredJobs: [FollowUp]{
        var result = jobs
        
        if let filter = selectedFilter {
            result = result.filter { $0.status == filter }
        }
        
        if !searchText.isEmpty{
            result = result.filter{
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.emailSubject.localizedCaseInsensitiveContains(searchText) ||
                $0.stakeholder.name.localizedCaseInsensitiveContains(searchText) ||
                (($0.linkedTicket?.ticketKey.localizedCaseInsensitiveContains(searchText)) ?? false)
            }
        }
        
        return result
    }
    
    var jobViewModel: JobViewModel{
        let viewModel = JobViewModel()
        viewModel.jobs = filteredJobs
        viewModel.showAll = true
        return viewModel
    }
    
    // MARK: - Summary
    var summaryItems: [StatusSummary]{
        FollowUpStatus.allCases.map{ status in
            StatusSummary(status: status, count: summaryCounts[status, default: 0])
        }
    }

    var isEmpty: Bool { filteredJobs.isEmpty }
}
