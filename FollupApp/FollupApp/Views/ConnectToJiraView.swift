//
//  ConnectToJiraView.swift
//
//
//  Created by Bomanarakasura on 21/05/26.
//

import AuthenticationServices
import Foundation
import SwiftUI

struct JiraAuthURLResponse: Decodable {
    let connectUrl: String
}

struct ConnectToJiraView: View {
    private let loginURL = URL(
        string:
            "https://challenge2.test-bomsiwor.my.id/auth/jira/connect"
    )!
    private let scheme = "follupapp"

    @State private var isAuthLoading = false
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
            Color.themePrimary
                .ignoresSafeArea()

            VStack {
                Button {
                    isAuthLoading.toggle()
                    errorMessage = nil

                    Task {
                        do {
                            // MARK: Need to uncomment this
                            //                            let initAuthURL = try await getAuthUrl()
                            //
                            //                            initialAuthURL = initAuthURL.connectUrl

                            let response = try await login(
                                url:
                                    "https://challenge2.test-bomsiwor.my.id/auth/jira/dummy-callback",
                                callbackScheme: scheme
                            )
                        } catch AuthError.userCancelled {
                            errorMessage = "Oh no! Do not cancle the operation :("
                        } catch {
                            errorMessage = "Oh no! We fail to connect you, try again, sorry!"
                        }
                        
                        isAuthLoading.toggle()
                    }
                    
                } label: {
                    Label {
                        Text(
                            isAuthLoading ? "Connecting..." : "Connect to Jira"
                        )
                        .padding(.vertical, 10)
                    } icon: {
                        if isAuthLoading {
                            ProgressView()
                        } else {
                            Image(systemName: "app.connected.to.app.below.fill")
                        }
                    }
                }
                .buttonStyle(.glass)
                

                if errorMessage != nil {
                    Text(errorMessage!)
                        .foregroundStyle(errorMessage == nil ? .white : Color.themeAccent)
                }
            }
        }
    }

    func getAuthUrl() async throws -> JiraAuthURLResponse {
        // Fetch
        let (data, _) = try await URLSession.shared.data(from: loginURL)

        // Decode the JSON data
        let response = try JSONDecoder().decode(
            JiraAuthURLResponse.self,
            from: data
        )

        return response
    }

    private func login(url: String, callbackScheme: String) async throws
        -> Token
    {
        let tokenResponse = try await JiraAuthenticationService().login(
            with: url,
            callbackScheme: callbackScheme
        )

        return tokenResponse
    }
}

class JiraAuthenticationService: NSObject,
    ASWebAuthenticationPresentationContextProviding
{

    // Session handler
    private var authSession: ASWebAuthenticationSession?

    func login(with url: String, callbackScheme: String) async throws -> Token {
        // Generate authURL
        let authURL = URL(string: url)!

        return try await withCheckedThrowingContinuation { continuation in
            // Create session and callback handler
            authSession = ASWebAuthenticationSession(
                url: authURL,
                callbackURLScheme: callbackScheme
            ) { callback, error in
                // Handle error
                if let err = error {
                    // Handle user close the page before authentication finished
                    if let err = error as? ASWebAuthenticationSessionError {
                        switch err.code {
                        case .canceledLogin:
                            continuation.resume(
                                throwing: AuthError.userCancelled
                            )
                            return

                        default:
                            continuation.resume(throwing: err)
                            return
                        }
                    }

                    continuation.resume(throwing: err)
                    return
                }

                // Parse callback data to token
                guard let callback = callback,
                      let token = TokenParser.parse(from: callback) else {
                    continuation.resume(throwing: AuthError.invalidCallback)
                    return
                }
                
                // TODO: Store token data to keychain

                // Return token data
                continuation.resume(returning: token)
            }

            authSession?.presentationContextProvider = self
            authSession?.start()
        }

    }

    func presentationAnchor(for session: ASWebAuthenticationSession)
        -> ASPresentationAnchor
    {
        guard
            let windowScene = UIApplication.shared
                .connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first
        else {
            fatalError("Unable to find a window scene for authentication presentation.")
        }

        return windowScene.windows.first { $0.isKeyWindow }
            ?? windowScene.windows.first
            ?? UIWindow(windowScene: windowScene)
    }

}

enum AuthError: LocalizedError {
    case userCancelled
    case invalidCallback

    var errorDescription: String? {
        switch self {
        case .userCancelled:
            return "Login cancelled by user"

        case .invalidCallback:
            return "Invalid authentication callback"
        }
    }
}

#Preview {
    ConnectToJiraView()
}
