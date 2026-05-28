//
//  JiraTicketResponse.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 27/05/26.
//

import Foundation

struct JiraTicketAPIItem: Decodable {
	let jiraTicketId: String
	let jiraTitle: String
}

extension JiraTicketAPIItem {
	func toJiraTicket() -> JiraTicketItem {
		let title = jiraTitle.isEmpty ? jiraTicketId : jiraTitle
		return JiraTicketItem(
			id: jiraTicketId,
			ticketKey: jiraTicketId,
			title: title,
			iconName: "circle.circle.fill"
		)
	}
}
