//
//  JiraTicketModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import Foundation

struct JiraTicketItem: Identifiable {
    let id = UUID()
    let ticketKey: String
    let title: String
    let iconName: String
    let status: JiraStatus?
    
    init(ticketKey: String, title: String, iconName: String, status: JiraStatus? = nil) {
        self.ticketKey = ticketKey
        self.title = title
        self.iconName = iconName
        self.status = status
    }
}
