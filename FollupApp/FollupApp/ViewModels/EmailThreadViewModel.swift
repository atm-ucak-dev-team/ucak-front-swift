//
//  EmailThreadViewModel.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 27/05/26.
//

import Foundation

@Observable
final class EmailThreadViewModel {
    var state: EmailThreadState = .idle
    private let client: APIClient = APIClientRegistry.general
    var isLoading: Bool = false
    var errorMessage: String?
    private var hasLoaded: Bool = false
    private let dummyUserId = "cihuy"

    @MainActor
    func fetchThread(threadID: String) async {
        guard !hasLoaded else { return }
        hasLoaded = true
        isLoading = true
        state = .loading
        defer { isLoading = false }

        do {
            let response: ThreadsResponse = try await client.request(
                endpoint: "/api/v1/followups/\(threadID)",
                headers: ["X-User-Dummy-Id": "cihuy"]
            )
            let messages = response.threads.map { EmailMessage(from: $0) }
            let sorted = messages.sorted { $0.sentAt < $1.sentAt }
            state = .loaded(sorted)
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
            state = .failed(error)
            hasLoaded = false
        }
    }
}
