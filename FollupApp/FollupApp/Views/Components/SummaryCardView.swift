//
//  SummaryCardView.swift
//
//
//  Created by DIMAS DAFFA ERNANDA on 20/05/26.
//

import SwiftUI

struct SummaryCardView: View {
    var items: [SummaryCardItem]
    
    init(items: [SummaryCardItem]? = nil) {
        if let items = items, !items.isEmpty {
            self.items = items
        } else {
            self.items = [
                SummaryCardItem(title: "Replied", iconName: "checkmark", count: 0, color: Color.themeSecondary),
                SummaryCardItem(title: "Ongoing", iconName: "hourglass", count: 0, color: Color.themeAccent),
                SummaryCardItem(title: "Expired", iconName: "trash.fill", count: 0, color: Color.themeGray2)
            ]
        }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 5){
                        Image(systemName: item.iconName)
                            .font(.system(size: 19, weight: .semibold))
                        
                        Text(item.title)
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
                .background(item.color)
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
    SummaryCardView()
}

#Preview("With Data") {
    SummaryCardView(items: [
        SummaryCardItem(title: "Replied", iconName: "checkmark", count: 9, color: Color.themeSecondary),
        SummaryCardItem(title: "Ongoing", iconName: "hourglass", count: 12, color: Color.themeAccent),
        SummaryCardItem(title: "Expired", iconName: "trash.fill", count: 3, color: Color.themeGray2)
    ])
}
