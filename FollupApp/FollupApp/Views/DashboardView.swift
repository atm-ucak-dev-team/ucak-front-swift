//
//  DashboardView.swift
//  FollupApp
//
//  Created by ATMUCAK  on 17/05/26.
//

import SwiftUI

struct DashboardView: View {
    var summaryItems: [SummaryCardItem]?
    var jobItems: [JobRowCardModel] = []
    var ticketItems: [JiraTicketItem] = []
    
    var body: some View {
        NavigationStack(){
            VStack(spacing: 12){
                SummaryCardView(items: summaryItems)
                VStack(spacing: 8){
                    HStack(spacing: 12){
                        Text("Jobs")
                            .font(.system(size: 22))
                            .foregroundColor(Color.themeTypography)
                            .bold()
                        Button(action: {
                            print("View All List Jobs")
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color.themeTypography)
                                .frame(width: 36, height: 36)
                                .background(.ultraThickMaterial)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                        }
                        .buttonStyle(.plain)
                        .glassEffect()
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    JobRowCardView(jobs: jobItems)
                }
                VStack(spacing: 8){
                    HStack(spacing: 12){
                        Text("Tickets")
                            .font(.system(size: 22))
                            .foregroundColor(Color.themeTypography)
                            .bold()
                        Button(action: {
                            print("View All List Tickets")
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color.themeTypography)
                                .frame(width: 36, height: 36)
                                .background(.ultraThickMaterial)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                        }
                        .buttonStyle(.plain)
                        .glassEffect()
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    JiraTicketRowView(tickets: ticketItems)
                }
                Spacer()
            }
            .navigationTitle("Follup")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("Tombol plus ditekan")
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.themePrimary)
                            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                    }
                }
            }
        }
    }
}

#Preview("With Data") {
    DashboardView(
        summaryItems: [
            SummaryCardItem(title: "Replied", iconName: "checkmark", count: 9, color: Color.themeSecondary),
            SummaryCardItem(title: "Ongoing", iconName: "hourglass", count: 12, color: Color.themeAccent),
            SummaryCardItem(title: "Expired", iconName: "trash.fill", count: 3, color: Color.themeGray2)
        ],
        jobItems: [
            JobRowCardModel(jobName: "Job Name", dateInfo: "Next follow-up: Mon 12/5/2026", ticketInfo: "Jira Ticket: ADA-001", status: .ongoing),
            JobRowCardModel(jobName: "Job Name", dateInfo: "Next follow-up: Mon 12/5/2026", ticketInfo: "Jira Ticket: ADA-001", status: .replied),
            JobRowCardModel(jobName: "Job Name", dateInfo: "Last email: Mon 12/5/2026", ticketInfo: "Jira Ticket: ADA-002", status: .expired)
        ],
        ticketItems: [
            JiraTicketItem(title: "Jira Ticket", iconName: "circle.circle.fill"),
            JiraTicketItem(title: "Jira Ticket 2", iconName: "balloon.2.fill"),
            JiraTicketItem(title: "Jira Ticket 3", iconName: "pawprint.fill")
        ]
    )
}

#Preview("Empty Data") {
    DashboardView()
}
