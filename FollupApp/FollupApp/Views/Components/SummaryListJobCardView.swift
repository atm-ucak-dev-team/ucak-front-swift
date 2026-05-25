//
//  SummaryListJobCardView.swift
//  FollupApp
//
//  Created by Eileen Anindya on 21/05/26.
//

import SwiftUI

struct SummaryListJobCardView: View {
    let items: [StatusSummary]
    var body: some View {
        HStack {
            ForEach(Array(items.enumerated()), id: \.element.id) { (index: Int, item: StatusSummary) in
                if index > 0 {
                    Spacer()
                    Divider()
                        .frame(height: 90)
                    Spacer()
                }
                
                Spacer()
                VStack(spacing: 10) {
                    Image(systemName: item.status.iconName)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.themeTypography)
                    Text("\(item.count)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.themeTypography)
                    Text(item.status.rawValue.capitalized)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.themeTypography)
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.themeCardBackground)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
    }
}

#Preview("With Data"){
    SummaryListJobCardView(
        items: [
            StatusSummary(status: .replied, count: 2),
            StatusSummary(status: .ongoing, count: 1),
            StatusSummary(status: .expired, count: 3)
        ]
    )
}

#Preview("Empty Data"){
    SummaryListJobCardView(items: FollowUpStatus.allCases.map {
        StatusSummary(status: $0, count: 0)
    })
}
