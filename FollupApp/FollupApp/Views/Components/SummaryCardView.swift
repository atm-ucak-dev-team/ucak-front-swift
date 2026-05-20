//
//  SummaryCardView.swift
//
//
//  Created by DIMAS DAFFA ERNANDA on 20/05/26.
//

import SwiftUI

struct SummaryCardView: View {
    private let items: [SummaryCardItem] = [
        SummaryCardItem(title: "Replied", count: 9, color: Color.themeSecondary),
        SummaryCardItem(title: "Ongoing", count: 12, color: Color.themeAccent),
        SummaryCardItem(title: "Expired", count: 3, color: Color.themeGray2)
    ]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 5) {
                    Image(systemName: "checkmark")
                        .font(.system(size: 19, weight: .semibold))
                    
                    Text(item.title)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("\(item.count)")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 134)
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

#Preview {
    SummaryCardView()
}
