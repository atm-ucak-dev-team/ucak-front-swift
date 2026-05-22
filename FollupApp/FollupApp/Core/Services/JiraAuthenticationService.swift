//
//  JiraAuthenticationService.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//
import Foundation
import AuthenticationServices

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
                                throwing: JiraAuthError.userCancelled
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
                    continuation.resume(throwing: JiraAuthError.invalidCallback)
                    return
                }
                
                // Store token data to keychain
                KeychainManager.shared.save(token)

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
