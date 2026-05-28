//
//  JobDetailViewModel.swift
//  FollupApp
//
//  Created by Eileen Anindya on 24/05/26.
//

import Foundation

@Observable
class JobDetailViewModel {
    var job: FollowUp?
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let client: APIClient = APIClientRegistry.general
    
    init(job: FollowUp? = nil) {
        self.job = job
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    var title: String { job?.title ?? "-" }
    var status: FollowUpStatus { job?.status ?? .ongoing }
    
    var dueDate: String {
        guard let date = job?.nextFollowUpDate else { return "-" }
        return Self.dateFormatter.string(from: date)
    }
    
    var lastFollowUp: String {
        guard let date = job?.lastFollowUpDate else { return "-" }
        return Self.dateFormatter.string(from: date)
    }
    
    var stakeholderName: String {
        let name = job?.stakeholder.name ?? "-"
        return name.isEmpty ? "-" : name
    }
    
    var sendEmailEvery: String {
        guard let schedule = job?.schedule else { return "-" }
        return schedule.repeatInterval.rawValue.capitalized
    }
    
    @MainActor
    func fetchDetails() async {
        guard let jobId = job?.id else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            let response: FollowUpDetailResponse = try await client.request(
                endpoint: "/api/v1/followups/\(jobId.uuidString.lowercased())",
                headers: ["X-User-Dummy-Id": "cihuy"]
            )
            
            let ticket = JiraTicketItem(
                id: job?.linkedTicket?.id ?? "",
                ticketKey: job?.linkedTicket?.ticketKey ?? "",
                title: response.jiraTicketTitle ?? job?.linkedTicket?.title ?? "",
                iconName: "circle.circle.fill",
                status: response.jiraTicketStatus.flatMap { JiraStatus.from(apiStatus: $0) } ?? job?.linkedTicket?.status
            )
            
            let status = FollowUpStatus(apiValue: response.status) ?? .ongoing
            let schedule = response.toSchedule()
            
            // Map the parsed Date? properties from lastFollowUp etc.
            self.job = FollowUp(
                id: jobId,
                title: response.subject,
                status: status,
                linkedTicket: ticket,
                stakeholder: Stakeholder(id: UUID(), name: response.stakeholderName, email: "-"),
                lastFollowUpDate: response.lastFollowUp,
                nextFollowUpDate: response.expireDateTime, // Map expireDateTime as Due Date
                repliedAt: job?.repliedAt,
                schedule: schedule,
                emailSubject: response.subject,
                emailBody: job?.emailBody ?? ""
            )
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
            print("❌ [JobDetailViewModel] fetchDetails error: \(error)")
        }
        isLoading = false
    }
}
