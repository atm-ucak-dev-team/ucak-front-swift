//
//  JobRowCardView.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 20/05/26.
//

import SwiftUI

struct JobRowCardView: View {
    var jobs: [FollowUp] = []
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE d/M/yyyy"
        return formatter
    }()
    
    private func dateInfo(for job: FollowUp) -> String {
        switch job.status {
        case .expired:
            return "Last email: \(Self.dateFormatter.string(from: job.lastFollowUpDate))"
        case .ongoing, .replied:
            return "Next follow-up: \(Self.dateFormatter.string(from: job.nextFollowUpDate))"
        }
    }
    
    private func ticketInfo(for job: FollowUp) -> String? {
        guard let ticket = job.linkedTicket else { return nil }
        return "Jira Ticket: \(ticket.ticketKey)"
    }
    
    var body: some View {
        VStack(spacing: -5) {
            if jobs.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.8))
                    Text("No jobs found")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 32)
                .frame(maxWidth: .infinity)
            } else {
                ForEach(Array(jobs.enumerated()), id: \.element.id) { index, job in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(job.title)
                                .font(.system(size: 18))
                                .foregroundColor(Color.themeTypography)
                            Text(dateInfo(for: job))
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                            if let ticket = ticketInfo(for: job) {
                                Text(ticket)
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        
                        BadgeStatusCardView(status: job.status)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 10)
                    
                    if index < jobs.count - 1 {
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.themeCardBackground)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
        .padding(.horizontal, 20)
    }
}

#Preview("With Data") {
    JobRowCardView(jobs: [
        FollowUp(
            id: UUID(),
            title: "Azure Migration",
            status: .ongoing,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-001", title: "Azure Migration", iconName: "circle.circle.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Ujang Pintu", email: "ujang@mail.com"),
            lastFollowUpDate: Date(),
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            emailSubject: "Follow-Up",
            emailBody: "Dear Pak"
        ),
        FollowUp(
            id: UUID(),
            title: "Cloud Setup",
            status: .replied,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-002", title: "Cloud Setup", iconName: "balloon.2.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Boma", email: "boma@mail.com"),
            lastFollowUpDate: Date(),
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
            emailSubject: "Follow-Up",
            emailBody: "Dear Pak"
        ),
        FollowUp(
            id: UUID(),
            title: "Database Migration",
            status: .expired,
            stakeholder: Stakeholder(id: UUID(), name: "Rudi", email: "rudi@mail.com"),
            lastFollowUpDate: Date(),
            nextFollowUpDate: Date(),
            emailSubject: "Follow-Up",
            emailBody: "Dear Pak"
        )
    ])
}

#Preview("Empty State") {
    JobRowCardView()
}
