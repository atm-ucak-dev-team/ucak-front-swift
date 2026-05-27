//
//  EmailMessageViewModel.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 27/05/26.
//

import Foundation

@Observable
class EmailMessageViewModel {
    var trail: EmailMessage?
    
    init(trail: EmailMessage? = nil) {
        self.trail = trail
    }
    
    enum State {
        case idle
        case loading
        case loaded(EmailMessage)
        case failed(Error)
    }

    var state: State = .idle
    
    // MARK: - Date Formatter
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    // MARK: - Fetch
    func loadEmail(id: String) async {
        state = .loading
        do {
            let email = try await fetchEmail(id: id)
            state = .loaded(email)
        } catch {
            state = .failed(error)
        }
    }

    private func fetchEmail(id: String) async throws -> EmailMessage {
        // Replace with endpoint boma
        let url = URL(string: "https://api.example.com/emails/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(EmailMessage.self, from: data)
    }
    
}

