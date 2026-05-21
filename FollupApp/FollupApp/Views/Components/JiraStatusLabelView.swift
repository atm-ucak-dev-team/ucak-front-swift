//
//  JiraStatusLabelView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 21/05/26.
//

import SwiftUI

struct JiraStatusLabelView: View {

    var status: JiraStatus
    
    var body: some View {
        Text(status.rawValue)
            .font(Font.caption2.weight(.semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(status.color)
            .cornerRadius(999)
    }
}

#Preview ("Jira Status Label Collection") {
    VStack {
        JiraStatusLabelView(status: .inprogress)
        JiraStatusLabelView(status: .done)
        JiraStatusLabelView(status: .todo)
    }
}
