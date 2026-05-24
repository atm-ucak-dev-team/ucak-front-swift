//
//  JiraTicketRowView.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import SwiftUI

struct JiraTicketRowView: View {
    var viewModel: JiraTicketViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.isEmpty {
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
                ForEach(Array(viewModel.displayedTickets.enumerated()), id: \.element.id) { index, ticket in
                    VStack(spacing: 0) {
                        NavigationLink(value: ticket) {
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
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical, 10)
                        
                        if !viewModel.isLastItem(index) {
                            Divider()
                                .padding(.leading, 60)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 20)
    }
}

#Preview("With Data") {
    let vm = JiraTicketViewModel()
    vm.tickets = [
        JiraTicketItem(ticketKey: "ADA-001", title: "Jira Ticket", iconName: "circle.circle.fill"),
        JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill"),
        JiraTicketItem(ticketKey: "ADA-003", title: "Jira Ticket 3", iconName: "pawprint.fill")
    ]
    return JiraTicketRowView(viewModel: vm)
}

#Preview("Empty State") {
    JiraTicketRowView(viewModel: JiraTicketViewModel())
}
