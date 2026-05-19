//
//  OverviewCardView.swift
//  UcakFront
//
//  Created by DIMAS DAFFA ERNANDA on 19/05/26.
//

import SwiftUI

struct OverviewCardView: View {
    var body: some View {
        VStack(spacing: 10){
            ZStack(){
                HStack(){
                    Image(systemName: "checkmark")
                        .font(.system(size: 20))
                    Spacer()
                    Text("9")
                        .font(.system(size: 20))
                }
                Text("Replied")
                    .font(.system(size: 20))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.themeSecondary)
            )
            ZStack(){
                HStack(){
                    Image(systemName: "hourglass")
                        .font(.system(size: 20))
                    Spacer()
                    Text("17")
                        .font(.system(size: 20))
                }
                Text("Ongoing")
                    .font(.system(size: 20))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.themeAccent)
            )
            ZStack(){
                HStack(){
                    Image(systemName: "trash.fill")
                        .font(.system(size: 20))
                    Spacer()
                    Text("3")
                        .font(.system(size: 20))
                }
                Text("Expired")
                    .font(.system(size: 20))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.themeGray2)
            )
        }
        .foregroundColor(Color.white)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.themePrimary)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    OverviewCardView()
}
