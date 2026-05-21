//
//  AutomationScheduleModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import Foundation

struct AutomationSchedule: Codable {
    var startDate: Date            // Contoh: 7 March 2026
    var expiryDate: Date           // Contoh: 9 March 2026
    var frequency: Int             // Contoh: 2 (kali)
    var repeatInterval: String      // Contoh: "Daily"
    var requiresConfirmation: Bool // Contoh: true
}
