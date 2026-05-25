//
//  FollowUpModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import Foundation

struct FollowUp: Identifiable, Hashable {
    static func == (lhs: FollowUp, rhs: FollowUp) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    
    let id: UUID                       // Contoh: UUID()
    var title: String                  // Contoh: "Azure Migration Follow-Ups"
    var status: FollowUpStatus         // Contoh: .ongoing
    var linkedTicket: JiraTicketItem?  // Contoh: JiraTicketItem(ticketKey: "ADA-001", ...)
    var stakeholder: Stakeholder       // Contoh: Stakeholder(name: "Ujang Pintu", ...)
    var lastFollowUpDate: Date         // Contoh: 10 May 2026
    var nextFollowUpDate: Date         // Contoh: 15 May 2026
    var schedule: AutomationSchedule?  // Contoh: AutomationSchedule(frequency: 2, ...)
    
    // Email content
    var emailSubject: String           // Contoh: "Azure Migration Follow-Up"
    var emailBody: String              // Contoh: "Dear Pak Bom, Gimana ya pak?"
}
