//
//  JobRowCardView.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 20/05/26.
//

import SwiftUI

struct JobRowCardView: View {
    var jobs: [JobRowCardModel] = [
        JobRowCardModel(jobName: "Job Name", dateInfo: "Next follow-up: Mon 12/5/2026", ticketInfo: "Jira Ticket: ADA-001", status: .ongoing),
        JobRowCardModel(jobName: "Job Name", dateInfo: "Next follow-up: Mon 12/5/2026", ticketInfo: "Jira Ticket: ADA-001", status: .replied),
        JobRowCardModel(jobName: "Job Name", dateInfo: "Last email: Mon 12/5/2026", ticketInfo: "Jira Ticket: ADA-002", status: .expired)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
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
                            Text(job.jobName)
                                .font(.system(size: 18))
                                .foregroundColor(Color.themeTypography)
                            Text(job.dateInfo)
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                            Text(job.ticketInfo)
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        BadgeStatusCardView(status: job.status)
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 14)
                    
                    if index < jobs.count - 1 {
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.themeCardBackground)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
    }
}

#Preview("With Data") {
    JobRowCardView()
}

#Preview("Empty State") {
    JobRowCardView(jobs: [])
}
