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
    case unknown = "UNKNOWN"
}
