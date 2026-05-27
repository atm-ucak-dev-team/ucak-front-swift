//
//  EmailThreadView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 27/05/26.
//

import SwiftUI

struct EmailThreadView: View {
    let messages: [EmailMessage]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(messages) { msg in
                EmailMessageCardView(message: msg)
            }
        }
        .padding()
    }
}

#Preview("Email Thread") {
    EmailThreadView(messages: [
        MockData.sample,
        .init(
            id: "2",
            threadID: "123",
            inReplyToID: "1234",
            fromName: "Ujang Pintu",
            to: ["bomanarakasura@mail.com"],
            cc: [],
            subject: "Re: Azure Migration Follow-ups",
            body: "Thanks for the details. I’ve added a couple of questions...",
            sentAt: Date().addingTimeInterval(-1800)
        )
    ])
}
