//
//  JobViewModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 22/05/26.
//

import Foundation

@Observable
class JobViewModel {
    var jobs: [FollowUp] = []
    var showAll: Bool = false       //added by eileen
    
    private let maxDisplayCount = 3
    
    // MARK: - Computed Properties
    
    var isEmpty: Bool {
        jobs.isEmpty
    }
    
    var displayedJobs: [FollowUp] {
//        Array(jobs.prefix(maxDisplayCount))
        showAll ? jobs : Array(jobs.prefix(maxDisplayCount))        //added by eileen
    }
    
    var needsSpacerFill: Bool {
//        !isEmpty && displayedJobs.count < maxDisplayCount
        !isEmpty && !showAll && displayedJobs.count < maxDisplayCount       //added by eileen
    }
    
    var isLastItem: (Int) -> Bool {
        { [weak self] index in
            guard let self else { return true }
            return index >= self.displayedJobs.count - 1
        }
    }
    
    // MARK: - Date Formatting
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d/M/yyyy"
        return formatter
    }()
    
    // MARK: - Display Helpers
    
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
}
