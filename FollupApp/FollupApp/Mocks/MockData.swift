//
//  MockData.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 25/05/26.
//

import Foundation

// MARK: - Mock Data (DEBUG only)
// Remove or gate behind #if DEBUG before shipping to production.

enum MockData {
    
    // MARK: - Stakeholders
    
    static let stakeholders = [
        Stakeholder(id: UUID(), name: "Budi Santoso", email: "budi.santoso@company.com"),
        Stakeholder(id: UUID(), name: "Siti Rahayu", email: "siti.rahayu@company.com"),
        Stakeholder(id: UUID(), name: "Andi Wijaya", email: "andi.wijaya@company.com"),
        Stakeholder(id: UUID(), name: "Dewi Lestari", email: "dewi.lestari@vendor.com"),
        Stakeholder(id: UUID(), name: "Rizky Pratama", email: "rizky.pratama@company.com"),
    ]
    
    // MARK: - Jira Tickets
    
    static let tickets: [JiraTicketItem] = [
        JiraTicketItem(
            ticketKey: "ADA-001",
            title: "Azure Migration",
            iconName: "cloud.fill",
            status: .inprogress
        ),
        JiraTicketItem(
            ticketKey: "ADA-002",
            title: "Budget Approval Q3",
            iconName: "dollarsign.circle.fill",
            status: .todo
        ),
        JiraTicketItem(
            ticketKey: "ADA-003",
            title: "Security Audit",
            iconName: "lock.shield.fill",
            status: .done
        ),
        JiraTicketItem(
            ticketKey: "ADA-004",
            title: "Design System v2",
            iconName: "paintbrush.fill",
            status: .inprogress
        ),
        JiraTicketItem(
            ticketKey: "ADA-005",
            title: "API Gateway Setup",
            iconName: "server.rack",
            status: .todo
        ),
    ]
    
    // MARK: - Follow-Up Jobs
    
    static let jobs: [FollowUp] = [
        // Ongoing jobs
        FollowUp(
            id: UUID(),
            title: "Azure Migration Follow-Up",
            status: .ongoing,
            linkedTicket: tickets[0],
            stakeholder: stakeholders[0],
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            schedule: AutomationSchedule(
                startDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
                expiryDate: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
                frequency: 3,
                repeatInterval: .every2Days,
                requiresConfirmation: true
            ),
            emailSubject: "Follow-Up: Azure Migration Progress",
            emailBody: "Dear Pak Budi,\n\nMohon update terkait progress migrasi Azure.\n\nTerima kasih."
        ),
        FollowUp(
            id: UUID(),
            title: "Budget Approval Reminder",
            status: .ongoing,
            linkedTicket: tickets[1],
            stakeholder: stakeholders[1],
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
            schedule: AutomationSchedule(
                startDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                expiryDate: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
                frequency: 5,
                repeatInterval: .daily,
                requiresConfirmation: false
            ),
            emailSubject: "Follow-Up: Budget Approval Q3",
            emailBody: "Hi Ibu Siti,\n\nMohon konfirmasi terkait approval budget Q3.\n\nTerima kasih."
        ),
        FollowUp(
            id: UUID(),
            title: "Design System Review",
            status: .ongoing,
            linkedTicket: tickets[3],
            stakeholder: stakeholders[2],
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            schedule: AutomationSchedule(
                startDate: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
                expiryDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
                frequency: 2,
                repeatInterval: .every3Days,
                requiresConfirmation: true
            ),
            emailSubject: "Follow-Up: Design System v2 Review",
            emailBody: "Halo Pak Andi,\n\nApakah sudah ada feedback untuk design system v2?\n\nTerima kasih."
        ),
        
        // Replied jobs
        FollowUp(
            id: UUID(),
            title: "Security Audit Sign-off",
            status: .replied,
            linkedTicket: tickets[2],
            stakeholder: stakeholders[4],
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            schedule: AutomationSchedule(
                startDate: Calendar.current.date(byAdding: .day, value: -14, to: Date())!,
                expiryDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
                frequency: 4,
                repeatInterval: .weekly,
                requiresConfirmation: false
            ),
            emailSubject: "Follow-Up: Security Audit Approval",
            emailBody: "Pak Rizky,\n\nMohon approval untuk hasil security audit.\n\nTerima kasih."
        ),
        FollowUp(
            id: UUID(),
            title: "API Gateway Confirmation",
            status: .replied,
            linkedTicket: tickets[4],
            stakeholder: stakeholders[0],
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
            emailSubject: "Follow-Up: API Gateway Setup",
            emailBody: "Dear Pak Budi,\n\nMohon konfirmasi setup API Gateway.\n\nTerima kasih."
        ),
        
        // Expired jobs
        FollowUp(
            id: UUID(),
            title: "Vendor Contract Renewal",
            status: .expired,
            linkedTicket: tickets[1],
            stakeholder: stakeholders[3],
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            emailSubject: "Follow-Up: Contract Renewal",
            emailBody: "Dear Ibu Dewi,\n\nKami menunggu konfirmasi perpanjangan kontrak.\n\nTerima kasih."
        ),
        FollowUp(
            id: UUID(),
            title: "Server Decommission Approval",
            status: .expired,
            linkedTicket: tickets[0],
            stakeholder: stakeholders[2],
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -15, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: -8, to: Date())!,
            emailSubject: "Follow-Up: Server Decommission",
            emailBody: "Halo Pak Andi,\n\nMohon approval decommission server lama.\n\nTerima kasih."
        ),
    ]
    
    // MARK: - Populate ViewModel
    
    /// Populates a DashboardViewModel with all mock data
    static func populateDashboard(_ viewModel: DashboardViewModel) {
        viewModel.jobVM.jobs = jobs
        viewModel.ticketVM.tickets = tickets
    }
}
