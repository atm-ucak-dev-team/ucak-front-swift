//
//  ChooseJiraTicketView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import SwiftUI

struct ChooseJiraTicketView: View {
    @State var viewModel = JiraTicketCardViewModel()
    @State private var selectedTicket: JiraTicketItem? = nil
    
    // Standardized 2-column grid layout for beautiful, responsive card layout
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack {
            if viewModel.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "tray")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.8))
                    Text("No Tickets Found")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                    Text("Try reconnecting to your Jira account")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.tickets) { ticket in
                            JiraCardView(
                                ticket: ticket,
                                isSelected: selectedTicket?.id == ticket.id
                            )
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedTicket = ticket
                                }
                            }
                        }
                    }
                    .padding(20)
                }
            }
        }
        .navigationTitle("Choose a Jira Ticket")
        .navigationSubtitle("Pick one ticket from your Jira")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("Empty State") {
    NavigationStack {
        ChooseJiraTicketView()
    }
}

#Preview("Single Data") {
    NavigationStack {
        let vm = JiraTicketCardViewModel()
        vm.tickets = [
            JiraTicketItem(ticketKey: "ADA-001", title: "Jira Ticket", iconName: "circle.circle.fill", status: .done)
        ]
        return ChooseJiraTicketView(viewModel: vm)
    }
}

#Preview("Multiple Data") {
    NavigationStack {
        let vm = JiraTicketCardViewModel()
        vm.tickets = [
            JiraTicketItem(ticketKey: "ADA-001", title: "Refactor Job Detail Screen UI Layout", iconName: "circle.circle.fill", status: .done),
            JiraTicketItem(ticketKey: "ADA-002", title: "Complete MVVM Architecture Checklist", iconName: "balloon.2.fill", status: .inprogress),
            JiraTicketItem(ticketKey: "ADA-003", title: "Implement Jira Authentication Flow", iconName: "balloon.2.fill", status: .todo),
            JiraTicketItem(ticketKey: "ADA-004", title: "Release Beta Version 1.0.0 to TestFlight", iconName: "balloon.2.fill")
        ]
        return ChooseJiraTicketView(viewModel: vm)
    }
}
