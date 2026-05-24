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

    // MARK: - Child ViewModel (stored to prevent re-creation)
    private var _jobVM = JobViewModel()
    
    var jobViewModel: JobViewModel {
        _jobVM.jobs = filteredJobs
        _jobVM.showAll = true
        return _jobVM
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
    
    func isLastItem(_ index: Int) -> Bool {
        index >= filteredJobs.count - 1
    }
}
