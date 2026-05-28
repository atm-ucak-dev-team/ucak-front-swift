//
//  JiraStatusLabelModel.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import Foundation

enum JiraStatus: String, CaseIterable, Codable {
    case inprogress = "IN PROGRESS"
    case todo = "TO-DO"
    case done = "DONE"
    case inreview = "IN REVIEW"
    case unknown = "UNKNOWN"
    
    /// Maps the raw status string from the Jira API to a `JiraStatus` case.
    static func from(apiStatus: String) -> JiraStatus {
        switch apiStatus.lowercased() {
        case "to do":
            return .todo
        case "in progress":
            return .inprogress
        case "done":
            return .done
        case "in review":
            return .inreview
        default:
            return .unknown
        }
    }
}

