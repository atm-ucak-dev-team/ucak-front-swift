//
//  JiraTicketModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import Foundation
import SwiftUI

struct JiraTicketItem: Identifiable {
    let id = UUID() // Contoh: UUID()
    let ticketKey: String // ex: "ADA-001"
    let title: String // Contoh: "Azure Migration"
    let iconName: String // Contoh: "circle.circle.fill"
}
