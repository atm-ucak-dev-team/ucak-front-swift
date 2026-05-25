//
//  FollowUpFormViewModel.swift
//  FollupApp
//
//  Created by Eileen Anindya on 24/05/26.
//

import Foundation

@Observable
class FollowUpFormViewModel{
    var toEmail: String = ""
    var ccEmail: String = ""
    var emailSubject: String = ""
    var emailBody: String = ""
    
    var startDate: Date = Date()
    var expireDate: Date = Date()
    var frequency: String = ""
    var repeatInterval: RepeatInterval = .daily
    var confirmBeforeFollowUp: Bool = false
    
    var showConfirmation: Bool = false
    
    var linkedTicket: JiraTicketItem?
    
    func createFollowUp() -> FollowUp {
        FollowUp(
            id: UUID(),
            title: emailSubject,
            status: .ongoing,
            linkedTicket: linkedTicket,
            stakeholder: Stakeholder(id: UUID(), name: toEmail, email: toEmail),
            lastFollowUpDate: startDate,
            nextFollowUpDate: startDate,
            schedule: AutomationSchedule(
                startDate: startDate,
                expiryDate: expireDate,
                frequency: Int(frequency) ?? 1,
                repeatInterval: repeatInterval,
                requiresConfirmation: confirmBeforeFollowUp
            ),
            emailSubject: emailSubject,
            emailBody: emailBody
        )
    }
}
