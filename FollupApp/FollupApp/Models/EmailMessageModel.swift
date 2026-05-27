//
//  EmailMessageModel.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 27/05/26.
//

import Foundation

struct EmailMessage: Codable, Identifiable {
    let id: String
    let threadID: String
    let inReplyToID: String?
    let fromName: String    // Contoh: Bomanarakasura
    let to: [String]        // Contoh: "ujangpintu@mail.com"
    let cc: [String]        // Contoh: "mamanjendela@mail.com"
    let subject: String     // Contoh: "Azure Migration Follow-Ups"
    let body: String        // Contoh: "Dear... (message)"
    let sentAt: Date        // Contoh: "Azure Migration Follow-Ups"
}
