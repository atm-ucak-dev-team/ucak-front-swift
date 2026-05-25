//
//  ChooseJiraTicketView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import SwiftUI


struct ChooseJiraTicketView: View {
    @State var jiraItems: [JiraTicketItem] = []
    @State var viewModel: JiraTicketCardViewModel = JiraTicketCardViewModel()
    
    var body: some View {

            VStack {
                if viewModel.isEmpty {
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
                        LazyVStack (spacing: 22) {
                            ForEach(Array(viewModel.ticketRows.enumerated()), id: \.offset) { rowIndex, row in
                                HStack {
                                    HStack (spacing: 22) {
                                        ForEach(row, id: \.ticketKey) { ticket in
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
            .navigationSubtitle("Pick one ticket from your Jira")
            .navigationBarTitleDisplayMode(.inline)
     
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
