//
//  ChooseJiraTicketView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import SwiftUI

enum Tabs {
    case search
}


struct ChooseJiraTicketView: View {
    var jiraItems: [JiraTicketItem] = []
    var viewModel: JiraTicketCardViewModel = JiraTicketCardViewModel()
    
    var body: some View {

            VStack {
                if viewModel.isEmpty {
                    Text("Pick one ticket from your Jira")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    
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
                    .navigationTitle("Choose a Jira Ticket")
                    .navigationBarTitleDisplayMode(.large)
                    .padding(.vertical, 32)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    
                    ScrollView {
                        Text("Pick one ticket from your Jira")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                        LazyVStack (spacing: 22) {
                            ForEach(Array(viewModel.ticketRows.enumerated()), id: \.offset) { rowIndex, row in
                                HStack {
                                    HStack (spacing: 22) {
                                        ForEach(row) { ticket in
                                            JiraCardView(viewModel: viewModel, items: [ticket])
                                        }
                                        
                                        if row.count % 2 != 0 {
                                            Spacer(minLength: 175)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Choose a Jira Ticket")
            .navigationBarTitleDisplayMode(.large)
     
    }
}




#Preview ("Empty State") {
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

#Preview("Even Amount of Data") {
      NavigationStack {
          let vm = JiraTicketCardViewModel()
          vm.tickets = [
              JiraTicketItem(ticketKey: "ADA-001", title: "Jira Ticket", iconName: "circle.circle.fill", status: .done),
              JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill", status: .inprogress),
              JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill", status: .todo),
              JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill")
          ]
          return ChooseJiraTicketView(viewModel: vm)
      }
  }

#Preview("Odd Amount of Data") {
      NavigationStack {
          let vm = JiraTicketCardViewModel()
          vm.tickets = [
              JiraTicketItem(ticketKey: "ADA-001", title: "Jira Ticket", iconName: "circle.circle.fill", status: .done),
              JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill", status: .inprogress),
              JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill")
          ]
          return ChooseJiraTicketView(viewModel: vm)
      }
  }
