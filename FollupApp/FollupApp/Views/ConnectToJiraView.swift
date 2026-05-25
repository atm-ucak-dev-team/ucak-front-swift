//
//  ConnectToJiraView.swift
//
//
//  Created by Bomanarakasura on 21/05/26.
//

import AuthenticationServices
import Foundation
import SwiftUI

struct ConnectToJiraView: View {
    @Environment(InitialAuthViewModel.self) private var initialAuthVM
    @State private var vm = ConnectToJiraViewModel()

    var body: some View {
        ZStack {
            Color.themePrimary
                .ignoresSafeArea()

            VStack {

                Button {
                    Task {
                        await vm.connectJira()
                        
                        try? await Task.sleep(for: .seconds(2))
                        
                        if vm.authToken != nil {
                            withAnimation {
                                initialAuthVM.authState = .authenticated
                            }
                        }
                    }

                } label: {
                    buttonLabel
                }
                .buttonStyle(.glass)
                .disabled(vm.authToken != nil)

                if vm.errorMessage != nil {
                    Text(vm.errorMessage!)
                        .foregroundStyle(
                            vm.errorMessage == nil ? .white : Color.themeAccent
                        )
                }

                if vm.authToken != nil {
//                    debugTokenSection
                }
            }
        }
    }

    @ViewBuilder
    private var buttonLabel: some View {
        Label {
            if vm.authToken != nil {
                Text("Connected to Jira").padding(.vertical, 10)
            } else {
                Text(
                    vm.isAuthLoading
                        ? "Connecting..." : "Connect to Jira"
                )
                .padding(.vertical, 10)
            }
        } icon: {
            if vm.isAuthLoading {
                ProgressView()
            } else if vm.authToken != nil {
                Image(systemName: "checkmark.circle.fill").foregroundStyle(
                    .green
                )
            } else {
                Image(systemName: "app.connected.to.app.below.fill")
            }
        }
    }

    @ViewBuilder
    private var debugTokenSection: some View {
        VStack {
            Text(vm.authToken ?? "Invalid token")
            Text(vm.debugRefresh ?? "Invalid token")
            Text(vm.debugExpiredAt ?? "Invalid expiration")
            Text(vm.debugCloudId ?? "Invalid cloud")
        }
    }
}

#Preview {
    ConnectToJiraView()
}
