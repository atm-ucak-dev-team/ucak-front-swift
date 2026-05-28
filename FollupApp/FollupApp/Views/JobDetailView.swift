//
//  JobDetailView.swift
//  FollupApp
//
//  Created by Eileen Anindya on 23/05/26.
//

import SwiftUI

struct JobDetailView: View {
    @State var viewModel: JobDetailViewModel
    @State private var threadVM = EmailThreadViewModel()
    @State var emailTrail: [EmailMessage]
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12){
            if viewModel.job == nil{
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .font(.system(size: 48))
                        .foregroundColor(.gray.opacity(0.8))
                    Text("No job details found")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack(alignment: .leading, spacing: 8){
                    Text(viewModel.title)
                        .font(.system(size: 24, weight: .bold))
                    BadgeStatusCardView(status: viewModel.status)
                }
                .padding(.horizontal, 20)
                                
                VStack(spacing: 16){
                    detailRow(icon: "calendar", label: "Due Date", value: viewModel.dueDate)
                    detailRow(icon: "calendar", label: "Last Follow-up", value: viewModel.lastFollowUp)
                    detailRow(icon: "person", label: "Stakeholder name", value: viewModel.stakeholderName)
                    detailRow(icon: "envelope", label: "Send email every", value: viewModel.sendEmailEvery)
                }
                .padding(.horizontal, 20)
                
                HStack(alignment: .top, spacing: 10){
                    Image(systemName: "info.circle")
                        .foregroundColor(.themeTypography)
                    Text("There's no reply after 3 days, either check your inbox or move the Kanban")
                        .font(.system(size: 14))
                        .foregroundColor(.themeTypography)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.themeAccent.opacity(0.2))
                )
                .padding(.horizontal, 20)
                
                VStack {
                    Text("Email Activities")
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .background(Color.gray.opacity(0.2))
                
                
                Group {
                    switch threadVM.state {
                    case .idle, .loading:
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()

                    case .failed(let error):
                        ContentUnavailableView("Failed to load emails",
                                               systemImage: "exclamationmark.triangle",
                                               description: Text(error.localizedDescription))

                    case .loaded(let messages):
                        ScrollView {
                            EmailThreadView(messages: messages)
                        }
                    }
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if let jobId = viewModel.job?.id {
                await threadVM.fetchThread(threadID: jobId.uuidString.lowercased())
            }
        }
    }
    
    private func detailRow(icon: String, label: String, value: String) -> some View{
        HStack(spacing: 12){
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.gray)
                .frame(width: 24)
            
            Text(label)
                .foregroundColor(.gray)
                .frame(width: 130, alignment: .leading)
            
            Text(value)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.themeTypography)
        }
    }
}

#Preview("With Data") {
    JobDetailView(viewModel: JobDetailViewModel(
        job: FollowUp(
            id: UUID(),
            title: "Azure Migration Follow-Ups",
            status: .ongoing,
            linkedTicket: JiraTicketItem(ticketKey: "ADA-001", title: "Azure Migration", iconName: "circle.circle.fill"),
            stakeholder: Stakeholder(id: UUID(), name: "Ujang Pintu", email: "ujang@mail.com"),
            lastFollowUpDate: Calendar.current.date(byAdding: .day, value: -4, to: Date())!,
            nextFollowUpDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            schedule: AutomationSchedule(
                startDate: Date(),
                expiryDate: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
                frequency: 3,
                repeatInterval: .daily,
                requiresConfirmation: true
            ),
            emailSubject: "Follow-Up",
            emailBody: "Dear Pak Bom, gimana ya pak"
        )
    ),
        emailTrail: [MockData.sample,
                     .init(
                         id: "2",
                         threadID: "123",
                         inReplyToID: "1234",
                         fromName: "Ujang Pintu",
                         to: ["bomanarakasura@mail.com"],
                         cc: ["mamanjendela@mail.com"],
                         subject: "Re: Azure Migration Follow-ups",
                         body: "Thanks for the details. I’ve added a couple of questions...",
                         sentAt: Date().addingTimeInterval(-1800)
                     )]
)
}

#Preview("No Data") {
    JobDetailView(viewModel: JobDetailViewModel(job: nil), emailTrail: [])
}
