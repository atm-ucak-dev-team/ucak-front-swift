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

    func loadThread(threadID: String) async {
        state = .loading
        do {
            var messages = try await fetchMessages(threadID: threadID)
            // Sort ascending so the oldest is first and replies appear “stitched” below
            messages.sort { $0.sentAt < $1.sentAt }
            state = .loaded(messages)
        } catch {
            state = .failed(error)
        }
    }

    private func fetchMessages(threadID: String) async throws -> [EmailMessage] {
        // Replace with endpoint boma
        let url = URL(string: "https://api.example.com/threads/\(threadID)/messages")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([EmailMessage].self, from: data)
    }
}
