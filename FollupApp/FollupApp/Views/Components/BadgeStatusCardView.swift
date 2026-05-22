//
//  BadgeStatusCardView.swift
//  FollupApp
//
//  Created by DIMAS DAFFA ERNANDA on 21/05/26.
//

import SwiftUI

struct BadgeStatusCardView: View {
    let status: FollowUpStatus
    
    var body: some View {
        Text(status.rawValue)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(status.color)
            .glassEffect(.clear)
            .cornerRadius(12)
    }
}

#Preview {
    VStack {
        BadgeStatusCardView(status: .ongoing)
        BadgeStatusCardView(status: .replied)
        BadgeStatusCardView(status: .expired)
    }
}
