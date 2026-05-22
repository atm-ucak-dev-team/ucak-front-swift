//
//  FollowUpStatusUI.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 22/05/26.
//

import SwiftUI

extension FollowUpStatus {
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
