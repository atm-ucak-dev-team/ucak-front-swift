//
//  AllTicketsView.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 25/05/26.
//

import SwiftUI

struct AllTicketsView: View {
    @State var viewModel: AllTicketsViewModel

    var body: some View {
        VStack(spacing: 12) {
            // Segmented filter control
            Picker("Status", selection: Bindable(viewModel).selectedFilter) {
                Text("All").tag(JiraStatus?.none)
                ForEach(JiraStatus.allCases.filter { $0 != .unknown }, id: \.self) { status in
                    Text(status.rawValue.capitalized).tag(Optional(status))
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)
            
            ScrollView {
                if viewModel.filteredTickets.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "tray")
                            .font(.system(size: 48))
                            .foregroundColor(.gray.opacity(0.8))
                        Text("No tickets found")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 200)
                } else {
                    JiraTicketRowView(viewModel: viewModel.ticketViewModel)
                }
            }
        }
        .navigationTitle("All Tickets")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(.themeTypography)
        .searchable(
            text: Bindable(viewModel).searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Search tickets..."
        )
    }
}

#Preview("With Data") {
    let viewModel = AllTicketsViewModel()
    viewModel.tickets = MockData.tickets
    return NavigationStack {
        AllTicketsView(viewModel: viewModel)
    }
}

#Preview("Empty Data") {
    AllTicketsView(viewModel: AllTicketsViewModel())
}
