//
//  ListJobView.swift
//  FollupApp
//
//  Created by Eileen Anindya on 21/05/26.
//

import SwiftUI

struct ListJobView: View {
    @Environment(\.dismiss) var dismiss
    @State private var statusFilter = 0
    
//    let jobs: [JobRowCardModel] = [
//        JobRowCardModel(jobName: "Approval", dateInfo: "Next follow up: 21/06/2026", ticketInfo: "Jira Ticket: ADA-002", status: .ongoing),
//        JobRowCardModel(jobName: "Approval Budget", dateInfo: "Next follow up: 30/06/2026", ticketInfo: "Jira Ticket: ADA-003", status: .replied),
//        JobRowCardModel(jobName: "Approval Kartini's Day", dateInfo: "Next follow up: 10/06/2026", ticketInfo: "Jira Ticket: ADA-001", status: .ongoing)
//    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack{
                    VStack(spacing: 10){
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .medium))
                        Text("1")
                            .font(.system(size: 28, weight: .bold))
                        Text("Replied")
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    Spacer()
                    Divider()
                        .frame(height: 90)
                    Spacer()

                    VStack(spacing: 10){
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .medium))
                        Text("1")
                            .font(.system(size: 28, weight: .bold))
                        Text("Replied")
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    Spacer()
                    Divider()
                        .frame(height: 90)
                    Spacer()

                    VStack(spacing: 10){
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .medium))
                        Text("1")
                            .font(.system(size: 28, weight: .bold))
                        Text("Replied")
                            .font(.system(size: 16, weight: .medium))
                    }
                }
                .padding(30)
                .background(Color.themeBackground)
                .cornerRadius(26)
                
            
                Picker("Status", selection: $statusFilter) {
                    Text("All").tag(0)
                    Text("Replied").tag(1)
                    Text("Ongoing").tag(2)
                    Text("Expired").tag(3)
                }
                .pickerStyle(.segmented)
//                Text("Value: \(statusFilter)")
                
                }
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action:{
//                            dismiss()
//                        }){
//                            HStack{
//                                Image(systemName: "chevron.left")
//                                Text("Back")
//                            }
//                            .font(.system(size: 17, weight: .medium))
//                        }
//                    }
//                }
//                .navigationBarTitleDisplayMode(.inline)
            .padding()
            
//            JobRowCardView(jobs: jobs)
            
            
        }
    }
}

#Preview {
    ListJobView()
}
