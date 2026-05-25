//
//  JobDetailViewModel.swift
//  FollupApp
//
//  Created by Eileen Anindya on 24/05/26.
//

import Foundation

@Observable
class JobDetailViewModel{
    var job: FollowUp?
    
    init(job: FollowUp? = nil) {
        self.job = job
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    var title: String { job?.title ?? "-" }
    var status: FollowUpStatus { job?.status ?? .ongoing }
    var dueDate: String {
        guard let date = job?.nextFollowUpDate else { return "-" }
        return Self.dateFormatter.string(from: date)
    }
    var lastFollowUp: String {
        guard let date = job?.lastFollowUpDate else { return "-" }
        return Self.dateFormatter.string(from: date)
    }
    var stakeholderName: String { job?.stakeholder.name ?? "-" }
    var sendEmailEvery: String {
        guard let schedule = job?.schedule else { return "-" }
        return schedule.repeatInterval.rawValue
    }
}
