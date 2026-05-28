//
//  ChooseJiraTicketView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import SwiftUI

struct ChooseJiraTicketView: View {
    @State var viewModel = JiraTicketCardViewModel()
    
    // Standardized 2-column grid layout for beautiful, responsive card layout
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Search Bar
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search tickets...", text: $viewModel.searchText)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled()
                
                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.searchText = ""
                        Task {
                            await viewModel.fetchJiraIssues()
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 8)
            .onSubmit {
                Task {
                    await viewModel.fetchJiraIssues(search: viewModel.searchText)
                }
            }
            
            // MARK: - Content
            if viewModel.isLoading {
                Spacer()
                VStack(spacing: 12) {
                    ProgressView()
                        .scaleEffect(1.2)
                    Text("Loading tickets...")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
                Spacer()
            } else if let errorMessage = viewModel.errorMessage {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundColor(.orange.opacity(0.8))
                    Text("Something went wrong")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                    Text(errorMessage)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Button {
                        Task {
                            await viewModel.fetchJiraIssues(search: viewModel.searchText)
                        }
                    } label: {
                        Label("Retry", systemImage: "arrow.clockwise")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.themePrimary)
                }
                .padding(.horizontal, 32)
                Spacer()
            } else if viewModel.isEmpty {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "tray")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.8))
                    Text("No Tickets Found")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                    Text(viewModel.searchText.isEmpty
                         ? "Try reconnecting to your Jira account"
                         : "No tickets match \"\(viewModel.searchText)\"")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.tickets) { ticket in
                            NavigationLink(value: DashboardRoute.followUpForm(ticket)) {
                                JiraCardView(
                                    ticket: ticket,
                                    isSelected: false
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(20)
                }
                .refreshable {
                    await viewModel.fetchJiraIssues(search: viewModel.searchText)
                }
            }
        }
        .navigationTitle("Choose a Jira Ticket")
        .navigationSubtitle("Pick one ticket from your Jira")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            // Fetch tickets on appear
            await viewModel.fetchJiraIssues()
        }
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
