//
//  JiraCardView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import SwiftUI

struct JiraCardView: View {
    var item: [JiraStatusLabelModel] = []
    
    var body: some View {
        ForEach (Array(item.enumerated()), id: \.element.id) {
            index, jira in
            VStack (alignment: .leading, spacing: 12) {
                JiraStatusLabelView(status: .done)
                
                Text(jira.ticketName)
                    .frame(width: 125, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(Font.subheadline.weight(.regular))
                    .foregroundColor(.themeTypography)
                //                .background(Color.blue)
                
                Text(jira.ticketNumber)
                    .frame(width: 125, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(Font.caption.weight(.medium))
                    .foregroundColor(Color.gray)
                //                .background(Color.blue)
            }
            .frame(width: 145, alignment: .center)
            .padding(12)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
        }
        
    }
    
}


#Preview {
    JiraCardView()
}

#Preview ("With Data") {
    JiraCardView(item: [
        JiraStatusLabelModel(status: .done, ticketName: "Bikin Komponen Card", ticketNumber: "ADA-001")
    ])
}
