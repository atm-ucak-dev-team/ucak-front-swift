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
	let stakeholderName: String?
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

		var parsedKey = jiraTicketId
		var parsedTitle = jiraTicketId
		
		// Extract ticket key inside brackets [KEY] and the clean title
		if subject.hasPrefix("["), let closingBracketIndex = subject.firstIndex(of: "]") {
			let keyRange = subject.index(after: subject.startIndex)..<closingBracketIndex
			parsedKey = String(subject[keyRange]).trimmingCharacters(in: .whitespacesAndNewlines)
			
			let afterBracket = subject.index(after: closingBracketIndex)...
			var remainingText = String(subject[afterBracket]).trimmingCharacters(in: .whitespacesAndNewlines)
			
			if let followRange = remainingText.range(of: " - Follow", options: .backwards) {
				remainingText = String(remainingText[..<followRange.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
			}
			parsedTitle = remainingText.isEmpty ? jiraTicketId : remainingText
		}

		let ticket = JiraTicketItem(
			id: jiraTicketId,
			ticketKey: parsedKey,
			title: parsedTitle,
			iconName: "circle.circle.fill"
		)

		return FollowUp(
			id: UUID(uuidString: followupId) ?? UUID(),
			title: subject,
			status: status,
			linkedTicket: ticket,
			stakeholder: Stakeholder(id: UUID(), name: stakeholderName ?? "Unknown", email: "-"),
			lastFollowUpDate: lastFollowUp,
			nextFollowUpDate: nextFollowUp,
			repliedAt: repliedAt,
			schedule: nil,
			emailSubject: subject,
			emailBody: ""
		)
	}
}
