//
//  JiraStatusLabelModel.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import Foundation
import SwiftUI

enum JiraStatus: String {
    case inprogress = "IN PROGRESS"
    case todo = "TO-DO"
    case done = "DONE"
    
    var color: Color {
        switch self {
        case .inprogress: return Color.indigo
        case .todo: return Color.orange
        case .done: return Color.green
        }
    }
}

struct JiraStatusLabelModel: Identifiable {
    let id = UUID()
    let status: JiraStatus
    let ticketName: String
    let ticketNumber: String
}
