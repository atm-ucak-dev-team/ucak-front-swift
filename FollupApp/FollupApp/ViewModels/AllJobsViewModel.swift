//
//  AllJobsViewModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 25/05/26.
//

import Foundation

@Observable
class AllJobsViewModel {
    var jobs: [FollowUp] = []
    var searchText: String = ""
    var selectedFilter: FollowUpStatus? = nil
    
    // MARK: - Filtered Jobs
    var filteredJobs: [FollowUp] {
        var result = jobs
        
        if let filter = selectedFilter {
            result = result.filter { $0.status == filter }
        }
        
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.emailSubject.localizedCaseInsensitiveContains(searchText) ||
                $0.stakeholder.name.localizedCaseInsensitiveContains(searchText) ||
                (($0.linkedTicket?.ticketKey.localizedCaseInsensitiveContains(searchText)) ?? false)
            }
        }
        
        return result
    }
    
    // MARK: - Child ViewModel Helper
    private var _jobVM = JobViewModel()
    
    var jobViewModel: JobViewModel {
        _jobVM.jobs = filteredJobs
        _jobVM.showAll = true
        return _jobVM
    }
    
    // MARK: - Computed Summary
    var repliedCount: Int {
        jobs.filter { $0.status == .replied }.count
    }
    
    var ongoingCount: Int {
        jobs.filter { $0.status == .ongoing }.count
    }
    
    var expiredCount: Int {
        jobs.filter { $0.status == .expired }.count
    }
    
    var summaryItems: [StatusSummary] {
        [
            StatusSummary(status: .replied, count: repliedCount),
            StatusSummary(status: .ongoing, count: ongoingCount),
            StatusSummary(status: .expired, count: expiredCount)
        ]
    }
}

