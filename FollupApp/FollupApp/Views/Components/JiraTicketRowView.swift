//
//  JiraTicketRowView.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import SwiftUI

struct JiraTicketRowView: View {
    var tickets: [JiraTicketItem] = []
    
    var body: some View {
        VStack(spacing: 0) {
            if tickets.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "ticket")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.8))
                    Text("No tickets found")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 32)
                .frame(maxWidth: .infinity)
            } else {
                ForEach(Array(tickets.enumerated()), id: \.element.id) { index, ticket in
                    VStack(spacing: 0) {
                        HStack(spacing: 16) {
                            Image(systemName: ticket.iconName)
                                .font(.system(size: 28))
                                .foregroundColor(Color.themeSecondary)
                            
                            Text(ticket.title)
                                .font(.system(size: 17))
                                .foregroundColor(Color.themeTypography)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        .padding(.vertical, 10)
                        
                        if index != tickets.count - 1 {
                            Divider()
                                .padding(.leading, 60)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 0)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 20)
    }
}

#Preview("With Data") {
    JiraTicketRowView(tickets: [
        JiraTicketItem(ticketKey: "ADA-001", title: "Jira Ticket", iconName: "circle.circle.fill"),
        JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill"),
        JiraTicketItem(ticketKey: "ADA-003", title: "Jira Ticket 3", iconName: "pawprint.fill")
    ])
}

#Preview("Empty State") {
    JiraTicketRowView()
}
