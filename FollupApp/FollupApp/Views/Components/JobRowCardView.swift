//
//  JobRowCardView.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 20/05/26.
//

import SwiftUI

struct JobRowCardView: View {
    var viewModel: JobViewModel
    var fixedMinHeight: CGFloat = 200       //added by eileen
    
    var body: some View {
        VStack(spacing: -5) {
            if viewModel.isEmpty {
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
                ForEach(Array(viewModel.displayedJobs.enumerated()), id: \.element.id) { index, job in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(job.title)
                                .font(.system(size: 18))
                                .foregroundColor(Color.themeTypography)
                            Text(viewModel.dateInfo(for: job))
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                            if let ticket = viewModel.ticketInfo(for: job) {
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
                    .onTapGesture {     //added by eileen, for debugging
                        print("Job clicked: \(job.title)")
                    }
                    
                    if !viewModel.isLastItem(index) {
                        Divider()
                    }
                }

            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
        .frame(minHeight: viewModel.isEmpty ? 200 : fixedMinHeight)       //edited by eileen
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.themeCardBackground)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
        .padding(.horizontal, 20)
    }
}

#Preview("With Data") {
    let vm = JobViewModel()
    vm.jobs = [
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
    ]
    return JobRowCardView(viewModel: vm)
}

#Preview("Empty State") {
    JobRowCardView(viewModel: JobViewModel())
}
