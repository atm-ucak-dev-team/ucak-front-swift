//
//  APIClientExample.swift
//  FollupApp
//
//  Created by Bomanarakasura on 22/05/26.
//

import Foundation
import SwiftUI

// Models
struct Todo: Decodable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

// View Models
@Observable
class PostsViewModel {
    // Inject API Client
    private let client: APIClient = APIClientRegistry.general

    var isLoading = false
    var errorMessage: String?
    
    var todo: Todo?
    
    func fetchTodo() async {
        isLoading = true
        defer { isLoading = false }
        do {
            todo = try await client.request(endpoint: "/todos/1")
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
    }
}

struct PostsView: View {
    @State private var vm = PostsViewModel()

    var body: some View {
        NavigationStack {
            Text(String(vm.todo?.id ?? 0) ?? "Loading...")
            
            Text(vm.todo?.title ?? "Loading...")
            .navigationTitle("Todo")
            .overlay {
                if vm.isLoading { ProgressView() }
            }
            .alert("Error", isPresented: Binding(
                get: { vm.errorMessage != nil },
                set: { if !$0 { vm.errorMessage = nil } }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(vm.errorMessage ?? "")
            }
            // Use task to fetch API Asynchronously when view is appearing
            .task { await vm.fetchTodo() }
        }
    }
}

#Preview {
    PostsView()
}
