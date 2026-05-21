//
//  SummaryListJobCardView.swift
//  FollupApp
//
//  Created by Eileen Anindya on 21/05/26.
//

import SwiftUI

struct SummaryListJobCardView: View {
    let jobs: [JobRowCardModel] = [
        JobRowCardModel(jobName: "Approval", dateInfo: "Next follow up: 21/06/2026", ticketInfo: "Jira Ticket: ADA-002", status: .ongoing),
        JobRowCardModel(jobName: "Approval Budget", dateInfo: "Next follow up: 30/06/2026", ticketInfo: "Jira Ticket: ADA-003", status: .replied),
        JobRowCardModel(jobName: "Approval Kartini's Day", dateInfo: "Next follow up: 10/06/2026", ticketInfo: "Jira Ticket: ADA-001", status: .ongoing)
    ]
    
    let items: [SummaryListJobItem] = [
        SummaryListJobItem(icon: "checkmark", title: "Replied", count: 2),
        SummaryListJobItem(icon: "hourglass", title: "Ongoing", count: 1),
        SummaryListJobItem(icon: "trash", title: "Expired", count: 3)
    ]
    
    var body: some View {
        HStack{
            ForEach(Array(items.enumerated()), id: \.element.id) { index,item in
                if index > 0 {
                    Divider()
                        .frame(height: 90)
                }
                
                Spacer()
                VStack(spacing: 10){
                    Image(systemName: item.icon)
                        .font(.system(size: 16, weight: .medium))
                    Text("\(item.count)")
                        .font(.system(size: 28, weight: .bold))
                    Text(item.title)
                        .font(.system(size: 16, weight: .medium))
                }
                Spacer()
            }
        }
        .padding(30)
        .background(Color.themeBackground)
        .cornerRadius(26)
    }
}

#Preview {
    SummaryListJobCardView()
}
