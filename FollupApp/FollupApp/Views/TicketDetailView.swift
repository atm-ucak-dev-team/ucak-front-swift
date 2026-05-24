//
//  TicketDetailView.swift
//  FollupApp
//
//  Created by Eileen Anindya on 21/05/26.
//

import SwiftUI

struct TicketDetailView: View {
//    @Environment(\.dismiss) var dismiss
    @State var ticketViewModel: TicketViewModel = TicketViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                VStack(spacing: 12){
                    SummaryListJobCardView(items: ticketViewModel.summaryItems)
                    
                    Picker("Status", selection: Bindable(ticketViewModel).selectedFilter) {
                        Text("All").tag(FollowUpStatus?.none)
                        ForEach(FollowUpStatus.allCases, id: \.self) { status in
                            Text(status.rawValue.capitalized).tag(Optional(status))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal, 20)
                
                ScrollView{
                    if ticketViewModel.filteredJobs.isEmpty{
                        VStack (spacing: 12){
                            Image(systemName: "tray")
                                .font(.system(size: 48))
                                .foregroundColor(.gray.opacity(0.8))
                            Text("No jobs found")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(minHeight: 200)
                    } else{
                        JobRowCardView(viewModel: ticketViewModel.jobViewModel, fixedMinHeight: 0)
                    }
                }
            }
            .navigationTitle(ticketViewModel.selectedJobTitle ?? "Ticket Details")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.themeTypography)
            .toolbar {
                ToolbarSpacer(.flexible, placement: .automatic)
                DefaultToolbarItem(kind: .search, placement: .automatic)
            }
            .searchable(
                text: Bindable(ticketViewModel).searchText,
                placement: .toolbar,
                prompt: "Search jobs..."
            )
            .searchToolbarBehavior(.automatic)
        }
    }
}

#Preview("With Data"){
    let viewModel = TicketViewModel()
    viewModel.selectedJobTitle = "Budget Approval"
    viewModel.jobs = [
        FollowUp(
            id: UUID(),
            title: "Approval Budget Q3",
            status: .ongoing,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-001", title: "Budget Approval", iconName: "circle.circle.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Budi Santoso", email: "budi.santoso@company.com"),
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            emailSubject: "Follow-Up: Budget Approval Q3",
            emailBody: "Dear Pak Budi, mohon konfirmasi terkait approval budget Q3."
        ),
        FollowUp(
            id: UUID(),
            title: "Server Migration Sign-off",
            status: .replied,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-001", title: "Server Migration", iconName: "circle.circle.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Siti Rahayu", email: "siti.rahayu@company.com"),
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
            emailSubject: "Follow-Up: Server Migration Sign-off",
            emailBody: "Hi Ibu Siti, mohon update terkait sign-off migration."
        ),
        FollowUp(
            id: UUID(),
            title: "Design Review Feedback",
            status: .ongoing,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-001", title: "Design Review", iconName: "circle.circle.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Andi Wijaya", email: "andi.wijaya@company.com"),
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            emailSubject: "Follow-Up: Design Review",
            emailBody: "Halo Pak Andi, apakah sudah ada feedback untuk design review?"
        ),
        FollowUp(
            id: UUID(),
            title: "Vendor Contract Renewal",
            status: .expired,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-001", title: "Contract Renewal", iconName: "circle.circle.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Dewi Lestari", email: "dewi.lestari@vendor.com"),
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            emailSubject: "Follow-Up: Contract Renewal",
            emailBody: "Dear Ibu Dewi, kami menunggu konfirmasi perpanjangan kontrak."
        ),
        FollowUp(
            id: UUID(),
            title: "Security Audit Approval",
            status: .replied,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-001", title: "Security Audit", iconName: "circle.circle.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Rizky Pratama", email: "rizky.pratama@company.com"),
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            emailSubject: "Follow-Up: Security Audit",
            emailBody: "Pak Rizky, mohon approval untuk hasil security audit."
        ),
        FollowUp(
            id: UUID(),
            title: "Security Audit Approval",
            status: .replied,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-001", title: "Security Audit", iconName: "circle.circle.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Rizky Pratama", email: "rizky.pratama@company.com"),
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
            emailSubject: "Follow-Up: Security Audit",
            emailBody: "Pak Rizky, mohon approval untuk hasil security audit."
        )

    ]
    return TicketDetailView(ticketViewModel: viewModel)
}

#Preview("Empty Data"){
    TicketDetailView()
}
