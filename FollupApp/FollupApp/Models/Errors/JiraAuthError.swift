//
//  JiraAuthError.swift
//  -
//
//  Created by Bomanarakasura on 22/05/26.
//

import Foundation

enum JiraAuthError: LocalizedError {
    case userCancelled
    case invalidCallback

    var errorDescription: String? {
        switch self {
        case .userCancelled:
            return "Login cancelled by user"

        case .invalidCallback:
            return "Invalid authentication callback"
        }
    }
}
