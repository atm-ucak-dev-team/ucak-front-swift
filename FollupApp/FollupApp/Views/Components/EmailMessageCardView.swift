//
//  EmailMessageCardView.swift
//  FollupApp
//
//  Created by Salwa Aisyah Adhani on 27/05/26.
//

import SwiftUI

struct EmailMessageCardView: View {
    let message: EmailMessage
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 20) {
                SymbolAvatar()
                VStack (alignment: .leading, spacing: 5) {
                    emailRow(label: "From: ", value: message.fromName)
                    emailRow(label: "To: ", value: message.to.joined(separator: ", "))
                    if !message.cc.isEmpty {
                        emailRow(label: String(localized: "Cc: "), value: message.cc.joined(separator: ", "))
                    }
                    
                    Text(Self.dateFormatter.string(from: message.sentAt))
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityElement(children: .combine)
            }
            
            Divider()
                .padding(.vertical, 5)
            
            VStack (alignment: .leading, spacing: 8) {
                Text(message.subject)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                
                Text(message.body)
                    .font(.system(size: 15))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        df.locale = .current
        return df
    }()
}



private func emailRow(label: String, value: String) -> some View {
    HStack(spacing: 5){
        Text(label)
            .font(.system(size: 15))
        Text(value)
            .font(.system(size: 13))
            .foregroundColor(.blue)
    }
}

struct SymbolAvatar: View {
    var size: CGFloat = 40
    var background: Color = .gray.opacity(0.2)
    var symbolColor: Color = .secondary

    var body: some View {
        ZStack {
            Circle()
                .fill(background)
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(symbolColor)
                .padding(size * 0.22)
        }
        .frame(width: size, height: size)
        .overlay(
            Circle().stroke(.quaternary, lineWidth: 1)
        )
        .accessibilityLabel("Profile picture placeholder")
    }
}

//#Preview {
//    EmailMessageCardView()
//}

#Preview ("Profile Picture Placeholder") {
    SymbolAvatar()
}

#Preview("Single Email Card") {
    EmailMessageCardView(message: MockData.sample)
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
            cc: ["mamanjendela@mail.com"],
            subject: "Re: Azure Migration Follow-ups",
            body: "Thanks for the details. I’ve added a couple of questions...",
            sentAt: Date().addingTimeInterval(-1800)
        )
    ])
}
