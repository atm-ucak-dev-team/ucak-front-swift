//
//  ScheduleCardView.swift
//  FollupApp
//
//  Created by Eileen Anindya on 24/05/26.
//

import SwiftUI

struct ScheduleCardView: View {
    @Binding var startDate: Date
    @Binding var expireDate: Date
    @Binding var frequency: String
    @Binding var repeatInterval: RepeatInterval
    @Binding var confirmBeforeNextFollowUp: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Automation Schedule")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.themeTypography)
            
            VStack(spacing: 0){
                DatePicker("Start", selection: $startDate)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                
                Divider()
                
                DatePicker("End", selection: $expireDate)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                
                Divider()
                            
                HStack{
                    Text("Frequency")
                    Spacer()
                    TextField("1", text: $frequency)
                        .foregroundColor(.gray)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
                
                Divider()
                
                HStack{
                    Text("Repeat")
                    Spacer()
                    Picker("", selection: $repeatInterval){
                        ForEach(RepeatInterval.allCases, id: \.self){ interval in
                            Text(interval.rawValue).tag(interval)
                        }
                    }
                    .tint(.gray)
                }
                .padding(.leading, 16)
                .padding(.trailing, 0)
                .padding(.vertical, 12)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 6){
                    Toggle("Confirm before sending", isOn: $confirmBeforeNextFollowUp)
                    
                    Text("Each email requires your approval before sending")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.themeFormBackground)
            )
        }
    }
}

#Preview {
    @Previewable @State var startDate = Date()
    @Previewable @State var expireDate = Calendar.current.date(byAdding: .day, value: 3, to: Date())!
    @Previewable @State var frequency = "2"
    @Previewable @State var repeatInterval = RepeatInterval.daily
    @Previewable @State var confirm = true
    
    ScheduleCardView(
        startDate: $startDate,
        expireDate: $expireDate,
        frequency: $frequency,
        repeatInterval: $repeatInterval,
        confirmBeforeNextFollowUp: $confirm
    )
//    .padding()
//    .background(Color.themeFormBackground)
}
