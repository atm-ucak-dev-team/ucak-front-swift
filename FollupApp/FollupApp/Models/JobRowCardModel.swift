//
//  JobRowCardModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 20/05/26.
//

import Foundation
import SwiftUI

enum JobStatus: String {
    case ongoing = "ONGOING"
    case replied = "REPLIED"
    case expired = "EXPIRED"
    
    var color: Color {
        switch self {
        case .ongoing: return Color.themeAccent
        case .replied: return Color.themeSecondary
        case .expired: return Color.themeGray2
        }
    }
}

struct JobRowCardModel: Identifiable {
    let id = UUID()
    let jobName: String
    let dateInfo: String
    let ticketInfo: String
    let status: JobStatus
}
