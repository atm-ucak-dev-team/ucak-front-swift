//
//  SummaryCardModel.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 20/05/26.
//

import Foundation
import SwiftUI

struct SummaryCardItem: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    let count: Int
    let color: Color
}
