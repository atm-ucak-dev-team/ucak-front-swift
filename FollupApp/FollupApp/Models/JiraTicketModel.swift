//
//  JiraTicketModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import Foundation

struct JiraTicketItem: Identifiable, Hashable {
    static func == (lhs: JiraTicketItem, rhs: JiraTicketItem) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    
    let id: String // Contoh: "jira​-20260518​-xyz"
    let ticketKey: String // ex: "ADA-001"
    let title: String // Contoh: "Azure Migration"
    let iconName: String // Contoh: "circle.circle.fill"
    let status: JiraStatus? // Contoh: .inprogress
    
    init(id: String = UUID().uuidString, ticketKey: String, title: String, iconName: String, status: JiraStatus? = nil) {
        self.id = id
        self.ticketKey = ticketKey
        self.title = title
        self.iconName = iconName
        self.status = status
    }
}
