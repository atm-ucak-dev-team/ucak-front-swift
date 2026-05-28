//
//  SplashScreenView.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import SwiftUI

enum AuthState {
    case loading
    case authenticated
    case unauthenticated
}

@Observable
class InitialAuthViewModel {
    var authState: AuthState = .loading
    
    func checkAuthState() async {
        // Get valid accessToken
        do {
            // If accesstoken is retrieved, mark state as authenticated
            if try await KeychainManager.shared.getValidAccessToken()?.isEmpty == false {
                authState = .authenticated
            }
        } catch {
            // Clear stale/expired tokens so ConnectToJiraView
            // doesn't see an old token and show "Connected to Jira" in a disabled state
            KeychainManager.shared.clearTokens()
            authState = .unauthenticated
        }
    }
}

struct SplashScreenView: View {
    @State private var active: Bool = false
    @State private var isPulsing: Bool = false
    @State private var initialViewModel: InitialAuthViewModel = .init()

    var body: some View {
        if active {
            // If active, show root view that will be routing to login view or dashboard view
            // Pass view model to root view hierarchy as context
            RootView()
                .environment(initialViewModel)
        } else {
            // Main Splash screen
            VStack {
                Image(systemName: "envelope.and.hand.raised.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.themeAccent)
                    .scaleEffect(isPulsing ? 1.1 : 1.0)
                    .opacity(isPulsing ? 0.8 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.2)
                            .repeatForever(autoreverses: true),
                        value: isPulsing
                    )
                    .onAppear {
                        isPulsing = true
                    }

                Text("Follup.")
                    .font(.largeTitle.bold())
            }
            .onAppear {
                Task {
                    // Get auth token
                    try? await Task.sleep(for: .seconds(3))
                    await initialViewModel.checkAuthState()
                    
                    // Activate root view after checking auth state
                    withAnimation {
                        active = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
