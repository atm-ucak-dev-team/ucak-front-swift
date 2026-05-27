//
//  FollowUpStatusModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import Foundation

enum FollowUpStatus: String, CaseIterable, Codable {
    case ongoing = "ONGOING"
    case replied = "REPLIED"
    case expired = "EXPIRED"

    init?(apiValue: String) {
        switch apiValue.lowercased() {
        case "ongoing": self = .ongoing
        case "replied": self = .replied
        case "expired": self = .expired
        default: return nil
        }
    }
}
