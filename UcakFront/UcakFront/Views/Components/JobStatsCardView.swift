//
//  JobStatsCardView.swift
//  UcakFront
//
//  Created by DIMAS DAFFA ERNANDA on 19/05/26.
//

import SwiftUI

struct JobStatsCardView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Job Name")
                        .font(.system(size: 18))
                        .foregroundColor(Color.themeTypography)
                    Text("Next follow-up: Mon 12/5/2026")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Text("Jira Ticket: ADA-001")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                Spacer()
                Text("ONGOING")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.themeAccent)
                    .cornerRadius(12)
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 14)
            
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Job Name")
                        .font(.system(size: 18))
                        .foregroundColor(Color.themeTypography)
                    Text("Next follow-up: Mon 12/5/2026")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Text("Jira Ticket: ADA-001")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                Spacer()
                Text("REPLIED")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.themeSecondary)
                    .cornerRadius(12)
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 14)
            
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Job Name")
                        .font(.system(size: 18))
                        .foregroundColor(Color.themeTypography)
                    Text("Last email: Mon 12/5/2026")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Text("Jira Ticket: ADA-002")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                Spacer()
                Text("EXPIRED")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.themeGray2)
                    .cornerRadius(12)
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 14)
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.themeCardBackground)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    JobStatsCardView()
}
