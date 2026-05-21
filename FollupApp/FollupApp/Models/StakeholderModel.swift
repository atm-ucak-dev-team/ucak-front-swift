//
//  StakeholderModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import Foundation

struct Stakeholder: Identifiable, Codable {
    let id: UUID // Contoh: UUID()
    let name: String // Contoh: "Ujang Pintu"
    let email: String // Contoh: "boma@mail.com"
}
