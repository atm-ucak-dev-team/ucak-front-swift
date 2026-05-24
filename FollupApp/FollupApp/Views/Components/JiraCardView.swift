//
//  JiraCardView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import SwiftUI

struct JiraCardView: View {
    var items: [JiraTicketItem] = []
    
    var body: some View {
        if items.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "tray")
                    .font(.system(size: 48))
                    .foregroundColor(.gray.opacity(0.8))
                Text("No Tickets Found")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                Text("Try reconnecting to your Jira account")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 32)
            .frame(maxWidth: .infinity)
        } else {
            ForEach (Array(items.enumerated()), id: \.element.id) { index, card in
                VStack (alignment: .leading, spacing: 12) {
                    VStack (alignment: .leading, spacing: 12) {
                        JiraStatusLabelView(status: card.status ?? .unknown)
                        Text(card.title)
                            .frame(width: 150, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .font(Font.subheadline.weight(.regular))
                            .foregroundColor(.themeTypography)
                    }
                    
                    Text(card.ticketKey)
                        .frame(width: 150, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(Font.caption.weight(.medium))
                        .foregroundColor(Color.gray)
                }
                .frame(width: 145, alignment: .leading)
                .padding(12)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
            }
        }
    }
}


#Preview ("With Data") {
    JiraCardView(items: [
        JiraTicketItem(ticketKey: "ADA-001", title: "Jira Ticket", iconName: "circle.circle.fill", status: .done),
        JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill", status: .inprogress),
        JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill")
    ])
}

#Preview ("Only One Card") {
    JiraCardView(items: [
        JiraTicketItem(ticketKey: "ADA-001", title: "Jira Ticket", iconName: "circle.circle.fill", status: .done)
    ])
}

#Preview ("Empty View") {
    JiraCardView()
}
