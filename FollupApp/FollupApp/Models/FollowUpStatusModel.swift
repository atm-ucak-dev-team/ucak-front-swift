//
//  FollowUpStatusModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import Foundation
import SwiftUI

enum FollowUpStatus: String, CaseIterable, Codable {
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
    
    var iconName: String {
        switch self {
        case .ongoing: return "hourglass"
        case .replied: return "checkmark"
        case .expired: return "trash.fill"
        }
    }
}
