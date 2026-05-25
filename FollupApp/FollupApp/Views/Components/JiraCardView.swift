//
//  JiraCardView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import SwiftUI

struct JiraCardView: View {
    let ticket: JiraTicketItem
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                JiraStatusLabelView(status: ticket.status ?? .unknown)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.themePrimary)
                        .font(.system(size: 18))
                }
            }
            
            Text(ticket.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.themeTypography)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(ticket.ticketKey)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.gray)
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? Color.themePrimary : Color.clear, lineWidth: 2)
        )
    }
}

#Preview("Selected") {
    JiraCardView(
        ticket: JiraTicketItem(ticketKey: "ADA-001", title: "Refactor Job Detail Screen UI", iconName: "circle.circle.fill", status: .inprogress),
        isSelected: true
    )
    .padding()
    .background(Color.themeBackground)
}

#Preview("Unselected") {
    JiraCardView(
        ticket: JiraTicketItem(ticketKey: "ADA-002", title: "Complete MVVM Architecture Review Checklist", iconName: "balloon.2.fill", status: .todo),
        isSelected: false
    )
    .padding()
    .background(Color.themeBackground)
}
