//
//  SummaryListJobCardModel.swift
//  FollupApp
//
//  Created by Eileen Anindya on 21/05/26.
//

import Foundation
import SwiftUI

struct SummaryListJobItem: Identifiable{
    let id = UUID()
    let icon: String
    let title: String
    let count: Int
}
