//
//  FollowUpResponse.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 25/05/26.
//

import Foundation

struct FollowUpAPIItem: Decodable {
	let followupId: String
	let jiraTicketId: String
	let subject: String
	let lastFollowUp: Date?
	let nextFollowUp: Date?
	let repliedAt: Date?
	let status: String
}

struct FollowUpStatisticResponse: Decodable {
	let replied: Int
	let ongoing: Int
	let expired: Int
}

extension FollowUpAPIItem {
	func toFollowUp() -> FollowUp? {
		guard let status = FollowUpStatus(apiValue: status) else { return nil }

		let ticket = JiraTicketItem(
			ticketKey: jiraTicketId,
			title: jiraTicketId,
			iconName: "circle.circle.fill"
		)

		return FollowUp(
			id: UUID(uuidString: followupId) ?? UUID(),
			title: subject,
			status: status,
			linkedTicket: ticket,
			stakeholder: Stakeholder(id: UUID(), name: "Unknown", email: "-"),
			lastFollowUpDate: lastFollowUp,
			nextFollowUpDate: nextFollowUp,
			repliedAt: repliedAt,
			schedule: nil,
			emailSubject: subject,
			emailBody: ""
		)
	}
}
