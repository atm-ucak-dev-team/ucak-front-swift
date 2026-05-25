//
//  EmailCardView.swift
//  FollupApp
//
//  Created by Eileen Anindya on 24/05/26.
//

import SwiftUI

struct EmailCardView: View {
    @Binding var toEmail: String
    @Binding var ccEmail: String
    @Binding var subject: String
    @Binding var emailBody: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            emailRow(label: "To:", text: $toEmail)
            Divider()
            
            emailRow(label: "Cc:", text: $ccEmail)
            Divider()
            
            emailRow(label: "Subject", text: $subject)
            Divider()
            
            TextEditor(text: $emailBody)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .scrollContentBackground(.hidden)
                .frame(height: 150)
                .background(Color.themeFormBackground)
                .frame(minHeight: 120)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.themeFormBackground)
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)

        )
        
    }
    
    private func emailRow(label: String, text: Binding<String>) -> some View {
        HStack(spacing: 4){
            Text(label)
                .foregroundColor(.gray)
            TextField("", text: text)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    @Previewable @State var to = "boma@mail.com"
    @Previewable @State var cc = "daffa@mail.com"
    @Previewable @State var subject = "Azure Migration Follow-up"
    @Previewable @State var emailBody = "Dear Pak Bom,\n\nGimana ya pak?\n\nThanks,\nEileen"

    EmailCardView(toEmail: $to, ccEmail: $cc, subject: $subject, emailBody: $emailBody)
        .padding()
}
