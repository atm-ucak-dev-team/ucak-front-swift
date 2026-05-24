//
//  JiraStatusUI.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 22/05/26.
//

import SwiftUI

extension JiraStatus {
    var color: Color {
        switch self {
        case .inprogress: return Color.indigo
        case .todo: return Color.orange
        case .done: return Color.green
        case .unknown: return Color.gray
        }
    }
}
