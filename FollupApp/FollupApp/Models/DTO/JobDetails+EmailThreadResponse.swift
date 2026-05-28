//
//  JobDetails+EmailThreadResponse.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 28/05/26.
//

import Foundation

struct JobDetailAPI: Decodable {
    let subject: String
    let status: String
    let lastFollowUp: Date?
    let stakeholderName: String
    let sendEmailEvery: String?
    let suggestion: String
}

struct ThreadsResponse: Codable {
    let threads: [EmailItem]
}

struct EmailItem: Codable, Identifiable {
    let id: String
    let gmailThreadId: String
    let status: String
    let body: String
    let lastSyncedAt: Date
}

extension JobDetailAPI {
    private func mapSendEmailEvery(_ value: String) -> RepeatInterval? {
        switch value.lowercased() {
        case "daily": return .daily
        case "every2days", "every_2_days", "every-2-days": return .every2Days
        case "every3days", "every_3_days", "every-3-days": return .every3Days
        case "weekly": return .weekly
        case "biweekly": return .biweekly
        default: return nil
        }
    }
    
    func toSchedule() -> AutomationSchedule? {
        guard let send = sendEmailEvery,
              let interval = mapSendEmailEvery(send) else {
            return nil
        }
        
        let start = Date()
        let expiry = Calendar.current.date(byAdding: .day, value: 14, to: start) ?? start
        
        // in case response untuk frequency-nya int
        let frequency: Int
        switch interval {
        case .daily: frequency = 1
        case .every2Days: frequency = 2
        case .every3Days: frequency = 3
        case .weekly: frequency = 1
        case .biweekly: frequency = 2
        }
        
        return AutomationSchedule(
            startDate: start,
            expiryDate: expiry,
            frequency: frequency,
            repeatInterval: interval,
            requiresConfirmation: true
        )
    }
}

extension EmailMessage {
    init(from dto: EmailItem) {
        self.id = dto.id
        self.threadID = dto.gmailThreadId
        self.inReplyToID = nil
        self.fromName = ""
        self.to = []
        self.cc = []
        self.subject = ""
        self.body = dto.body
        self.sentAt = dto.lastSyncedAt
    }
}
