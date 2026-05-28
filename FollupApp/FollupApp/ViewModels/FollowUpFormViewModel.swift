//
//  FollowUpFormViewModel.swift
//  FollupApp
//
//  Created by Eileen Anindya on 24/05/26.
//

import Foundation

@Observable
class FollowUpFormViewModel {
    var toEmail: String = ""
    var ccEmail: String = ""
    var emailSubject: String = ""
    var emailBody: String = ""
    
    var startDate: Date = Date()
    var expireDate: Date = Date()
    var frequency: Int = 1
    var repeatInterval: RepeatInterval = .daily
    var confirmBeforeFollowUp: Bool = false
    
    var showConfirmation: Bool = false
    var isSubmitting: Bool = false
    var submitError: String?
    var didSubmitSuccessfully: Bool = false
    
    var linkedTicket: JiraTicketItem?
    
    init(linkedTicket: JiraTicketItem? = nil) {
        self.linkedTicket = linkedTicket
        if let ticket = linkedTicket {
            self.emailSubject = "[\(ticket.ticketKey)] \(ticket.title) - Follow-Up"
        }
    }
    
    // MARK: - ISO8601 Formatter
    private static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()
    
    // MARK: - Submit Follow-Up to API
    
    /// Sends a POST request to create a new follow-up via the backend API.
    @MainActor
    func submitFollowUp() async {
        isSubmitting = true
        submitError = nil
        
        do {
            let requestBody = CreateFollowUpRequest(
                jiraTicketId: linkedTicket?.id ?? "",
                jiraTicketKey: linkedTicket?.ticketKey ?? "",
                jiraTicketTitle: linkedTicket?.title ?? emailSubject,
                jiraStakeholder: linkedTicket?.stakeholder ?? "",
                jiraTicketStatus: linkedTicket?.status?.rawValue ?? "UNKNOWN",
                to: toEmail,
                cc: ccEmail,
                subject: emailSubject,
                emailBody: emailBody,
                startDateTime: Self.iso8601Formatter.string(from: startDate),
                expireDateTime: Self.iso8601Formatter.string(from: expireDate),
                frequency: repeatInterval.rawValue,
                repeat: frequency,
                followupConfirmation: confirmBeforeFollowUp
            )
            
            let _: CreateFollowUpResponse = try await APIClientRegistry.authenticated.request(
                endpoint: "/api/v1/followups",
                method: .POST,
                body: requestBody,
                additionalHeaders: [:]
            )
            
            didSubmitSuccessfully = true
            print("✅ [FollowUpFormViewModel] Follow-up created successfully")
            
        } catch {
            submitError = (error as? APIError)?.errorDescription ?? error.localizedDescription
            print("❌ [FollowUpFormViewModel] submitFollowUp error: \(error)")
        }
        
        isSubmitting = false
    }
    
    // MARK: - Local Follow-Up (legacy, for offline/preview usage)
    
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
                frequency: frequency,
                repeatInterval: repeatInterval,
                requiresConfirmation: confirmBeforeFollowUp
            ),
            emailSubject: emailSubject,
            emailBody: emailBody
        )
    }
}
