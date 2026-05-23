//
//  ListJobViewModel.swift
//  FollupApp
//
//  Created by Eileen Anindya on 22/05/26.
//

import Foundation

@Observable
class ListJobViewModel{
    var jobs: [FollowUp] = []
    var searchText: String = ""
    
    var selectedFilter: FollowUpStatus? = nil
    
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

    var jobViewModel: JobViewModel {
        let viewModel = JobViewModel()
        viewModel.jobs = filteredJobs
        viewModel.showAll = true
        return viewModel
    }
    
    var isEmpty: Bool{
        filteredJobs.isEmpty
    }
    
    var repliedCount: Int{
        jobs.filter{ $0.status == .replied }.count

    }
    
    var ongoingCount: Int{
        jobs.filter{ $0.status == .ongoing }.count
    }
    
    var expiredCount: Int{
        jobs.filter{ $0.status == .expired }.count
    }
    
    var summaryItems: [StatusSummary] {
        [
            StatusSummary(status: .replied, count: repliedCount),
            StatusSummary(status: .ongoing, count: ongoingCount),
            StatusSummary(status: .expired, count: expiredCount)
        ]
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d/M/yyy"
        return formatter
    }()
    
    func dateInfo(for job: FollowUp) -> String {
        switch job.status {
        case .expired:
            return "Last email: \(Self.dateFormatter.string(from: job.lastFollowUpDate))"
        case .ongoing, .replied:
            return "Next follow-up: \(Self.dateFormatter.string(from: job.nextFollowUpDate))"
        }
    }
    
    func ticketInfo(for job: FollowUp) -> String? {
        guard let ticket = job.linkedTicket else { return nil }
        return "Jira Ticket: \(ticket.ticketKey)"
    }
    
    func isLastItem(_ index: Int) -> Bool {
        index >= filteredJobs.count - 1
    }
}
