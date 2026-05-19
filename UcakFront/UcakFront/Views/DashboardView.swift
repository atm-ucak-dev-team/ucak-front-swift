//
//  DashboardView.swift
//  UcakFront
//
//  Created by DIMAS DAFFA ERNANDA on 17/05/26.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack(){
            VStack(spacing: 20){
                OverviewCardView()
                
                VStack(spacing: 12){
                    HStack(spacing: 12){
                        Text("List Job")
                            .font(.system(size: 22))
                            .foregroundColor(Color.themeTypography)
                            .bold()
                        Button(action: {
                            print("View All List Job")
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color.themeTypography)
                                .frame(width: 36, height: 36)
                                .background(.ultraThickMaterial)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                        }
                        .buttonStyle(.plain)
                        .glassEffect()
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    JobStatsCardView()
                }
                Spacer()
            }
            .navigationTitle("Follup")
            .toolbar {
                ToolbarItem() {
                    Button(action: {
                        print("Tombol plus ditekan")
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.themePrimary)
                            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
