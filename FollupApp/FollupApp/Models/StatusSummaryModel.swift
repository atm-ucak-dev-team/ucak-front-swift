//
//  StatusSummaryModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import Foundation

struct StatusSummary: Identifiable {
    let id = UUID()              // Contoh: UUID()
    let status: FollowUpStatus   // Contoh: .replied
    let count: Int               // Contoh: 9
}
