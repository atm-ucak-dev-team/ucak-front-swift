//
//  RootView.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import SwiftUI

struct RootView: View {
    @Environment(InitialAuthViewModel.self) var viewModel

    var body: some View {
        switch viewModel.authState {
        case .loading:
            Text("Follup.")
                .font(.largeTitle.bold())
            ProgressView()

        case .unauthenticated:
            ConnectToJiraView()

        case .authenticated:
            DashboardView()
        }
    }
}

#Preview {
    RootView()
}
