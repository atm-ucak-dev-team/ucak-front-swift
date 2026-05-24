//
//  DashboardView.swift
//  FollupApp
//
//  Created by ATMUCAK  on 17/05/26.
//

import SwiftUI
struct DashboardView: View {
    @State var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack(){
            VStack(spacing: 12){
                SummaryCardView(items: viewModel.summaryItems)
                VStack(spacing: 8){
                    HStack(spacing: 12){
                        Text("Jobs")
                            .font(.system(size: 22))
                            .foregroundColor(Color.themeTypography)
                            .bold()
                        NavigationLink(value: DashboardRoute.allJobs) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color.themeTypography)
                                .frame(width: 36, height: 36)
                                .background(.ultraThickMaterial)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                        }
                        .buttonStyle(.plain)
                        .glassEffect()
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    JobRowCardView(viewModel: viewModel.jobVM)
                }
                VStack(spacing: 8){
                    HStack(spacing: 12){
                        Text("Tickets")
                            .font(.system(size: 22))
                            .foregroundColor(Color.themeTypography)
                            .bold()
                        Button(action: {
                            print("View All List Tickets")
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color.themeTypography)
                                .frame(width: 36, height: 36)
                                .background(.ultraThickMaterial)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                        }
                        .buttonStyle(.plain)
                        .glassEffect()
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    JiraTicketRowView(viewModel: viewModel.ticketVM)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("Follup")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("Tombol plus ditekan")
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.themePrimary)
                            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                    }
                }
            }
            .navigationDestination(for: DashboardRoute.self) { route in
                switch route {
                case .allJobs:
                    AllJobsView(viewModel: viewModel.allJobsVM())
                case .jobDetail(let job):
                    JobDetailView(viewModel: JobDetailViewModel(job: job))
                case .ticketDetail(let ticket):
                    TicketDetailView(ticketViewModel: viewModel.ticketDetailVM(for: ticket))
                }
            }
        }
    }
}

#Preview("With Data") {
    let vm = DashboardViewModel()
    vm.jobVM.jobs = [
        FollowUp(
            id: UUID(),
            title: "Azure Migration",
            status: .ongoing,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-001", title: "Azure Migration", iconName: "circle.circle.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Ujang Pintu", email: "ujang@mail.com"),
            lastFollowUpDate: Date(),
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            emailSubject: "Follow-Up",
            emailBody: "Dear Pak"
        ),
        FollowUp(
            id: UUID(),
            title: "Cloud Setup",
            status: .replied,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-002", title: "Cloud Setup", iconName: "balloon.2.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Boma", email: "boma@mail.com"),
            lastFollowUpDate: Date(),
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
            emailSubject: "Follow-Up",
            emailBody: "Dear Pak"
        ),
        FollowUp(
            id: UUID(),
            title: "Database Migration",
            status: .expired,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-003", title: "Cloud Setup", iconName: "balloon.2.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Rudi", email: "rudi@mail.com"),
            lastFollowUpDate: Date(),
            nextFollowUpDate: Date(),
            emailSubject: "Follow-Up",
            emailBody: "Dear Pak"
        )
    ]
    vm.ticketVM.tickets = [
        JiraTicketItem(ticketKey: "ADA-001", title: "Jira Ticket", iconName: "circle.circle.fill"),
        JiraTicketItem(ticketKey: "ADA-002", title: "Jira Ticket 2", iconName: "balloon.2.fill"),
        JiraTicketItem(ticketKey: "ADA-003", title: "Jira Ticket 3", iconName: "pawprint.fill")
    ]
    return DashboardView(viewModel: vm)
}

#Preview("Empty Data") {
    DashboardView()
}
