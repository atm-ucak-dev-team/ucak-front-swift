//
//  AllJobsView.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 25/05/26.
//

import SwiftUI

struct AllJobsView: View {
    @State var viewModel: AllJobsViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(spacing: 12) {
                SummaryListJobCardView(items: viewModel.summaryItems)
                
                Picker("Status", selection: Bindable(viewModel).selectedFilter) {
                    Text("All").tag(FollowUpStatus?.none)
                    ForEach(FollowUpStatus.allCases, id: \.self) { status in
                        Text(status.rawValue.capitalized).tag(Optional(status))
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal, 20)
            
            ScrollView {
                if viewModel.filteredJobs.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "tray")
                            .font(.system(size: 48))
                            .foregroundColor(.gray.opacity(0.8))
                        Text("No jobs found")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 200)
                } else {
                    JobRowCardView(viewModel: viewModel.jobViewModel, fixedMinHeight: 0)
                }
            }
        }
        .navigationTitle("All Jobs")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(.themeTypography)
        .searchable(
            text: Bindable(viewModel).searchText,
            placement: .navigationBarDrawer(displayMode:
                    .automatic),
            prompt: "Search jobs..."
        )
        
    }
}

#Preview("With Data") {
    let viewModel = AllJobsViewModel()
    viewModel.jobs = MockData.jobs
    return NavigationStack {
        AllJobsView(viewModel: viewModel)
    }
}

#Preview("Empty Data") {
    AllJobsView(viewModel: AllJobsViewModel())
}
