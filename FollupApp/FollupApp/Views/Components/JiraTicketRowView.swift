//
//  JiraTicketRowView.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import SwiftUI

struct JiraTicketRowView: View {
    private let tickets: [JiraTicketItem] = [
        JiraTicketItem(title: "Jira Ticket", iconName: "circle.circle.fill"),
        JiraTicketItem(title: "Jira Ticket 2", iconName: "balloon.2.fill"),
        JiraTicketItem(title: "Jira Ticket 3", iconName: "pawprint.fill")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(tickets.enumerated()), id: \.element.id) { index, ticket in
                VStack(spacing: 0) {
                    HStack(spacing: 16) {
                        Image(systemName: ticket.iconName)
                            .font(.system(size: 24))
                            .foregroundColor(Color.themeSecondary)
                            .frame(width: 44, height: 44)
                        
                        Text(ticket.title)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color.themeTypography)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray.opacity(0.5))
                    }
                    .padding(.vertical, 12)
                    
                    if index != tickets.count - 1 {
                        Divider()
                            .padding(.leading, 60)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 20)
    }
}

#Preview {
    JiraTicketRowView()
}
