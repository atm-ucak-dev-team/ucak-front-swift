//
//  SummaryCardView.swift
//
//
//  Created by DIMAS DAFFA ERNANDA on 20/05/26.
//

import SwiftUI

struct SummaryCardView: View {
    let items: [StatusSummary]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 5){
                        Image(systemName: item.status.iconName)
                            .font(.system(size: 19, weight: .semibold))
                        
                        Text(item.status.rawValue.capitalized)
                            .font(.subheadline)
                    }
                    Text("\(item.count)")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(item.status.color)
                .cornerRadius(12)
                .glassEffect(.clear, in: .rect(cornerRadius:12))
            }
        }
        .padding(10)
        .background(Color.themePrimary)
        .cornerRadius(15)
        .padding(.horizontal,20)
    }
}

#Preview("Empty Data") {
    SummaryCardView(items: FollowUpStatus.allCases.map {
        StatusSummary(status: $0, count: 0)
    })
}

#Preview("With Data") {
    SummaryCardView(items: [
        StatusSummary(status: .replied, count: 9),
        StatusSummary(status: .ongoing, count: 12),
        StatusSummary(status: .expired, count: 3)
    ])
}
