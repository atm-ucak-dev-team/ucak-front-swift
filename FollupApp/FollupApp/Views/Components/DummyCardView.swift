//
//  DummyCardView.swift
//  FollupApp
//
//  Created by ATMUCAK  on 17/05/26.
//

import SwiftUI

struct DummyCardView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            VStack(spacing: 12) {
                Text("9")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.4, blue: 0.6))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Text("Replied")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.blue.opacity(0.1))
                    )
            }
            .frame(maxWidth: .infinity)
            .frame(height: 130)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.themeSecondary)
                    .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
            )
            
            VStack(spacing: 12) {
                Text("17")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.25))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Text("Ongoing")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.green.opacity(0.1))
                    )
            }
            .frame(maxWidth: .infinity)
            .frame(height: 130)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.themeAccent)
                    .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
            )
            
            VStack(spacing: 12) {
                Text("3")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(red: 0.7, green: 0.15, blue: 0.15))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Text("Expired")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.red.opacity(0.1))
                    )
            }
            .frame(maxWidth: .infinity)
            .frame(height: 130)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.themeGray2)
                    .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}

#Preview {
    DummyCardView()
}
