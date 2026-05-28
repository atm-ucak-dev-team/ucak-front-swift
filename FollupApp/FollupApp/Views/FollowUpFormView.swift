//
//  FollowUpFormView.swift
//  FollupApp
//
//  Created by Eileen Anindya on 24/05/26.
//

import SwiftUI

struct FollowUpFormView: View {
    @State var viewModel: FollowUpFormViewModel = FollowUpFormViewModel()
    @Environment(\.dismiss) private var dismiss
    var onSuccess: (() -> Void)? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                EmailCardView(
                    toEmail: Bindable(viewModel).toEmail,
                    ccEmail: Bindable(viewModel).ccEmail,
                    subject: Bindable(viewModel).emailSubject,
                    emailBody: Bindable(viewModel).emailBody
                )
                
                ScheduleCardView(
                    startDate: Bindable(viewModel).startDate,
                    expireDate: Bindable(viewModel).expireDate,
                    frequency: Bindable(viewModel).frequency,
                    repeatInterval: Bindable(viewModel).repeatInterval,
                    confirmBeforeNextFollowUp: Bindable(viewModel).confirmBeforeFollowUp
                )
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationTitle("Follow-up Form")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showConfirmation = true
                    } label: {
                        if viewModel.isSubmitting {
                            ProgressView()
                                .scaleEffect(0.8)
                        } else {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color.themePrimary)
                                .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
                        }
                    }
                    .buttonStyle(.plain)
                    .disabled(viewModel.isSubmitting)
                }
            }
            .alert("Create this follow up?", isPresented: Bindable(viewModel).showConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Proceed") {
                    Task {
                        await viewModel.submitFollowUp()
                    }
                }
            } message: {
                Text("You can still modify the automation setup later.")
            }
            .alert("Error", isPresented: Binding(
                get: { viewModel.submitError != nil },
                set: { if !$0 { viewModel.submitError = nil } }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.submitError ?? "Something went wrong.")
            }
            .onChange(of: viewModel.didSubmitSuccessfully) { _, success in
                if success {
                    onSuccess?()
                    dismiss()
                }
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .disabled(viewModel.isSubmitting)
        .overlay {
            if viewModel.isSubmitting {
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                    .overlay {
                        VStack(spacing: 12) {
                            ProgressView()
                                .scaleEffect(1.2)
                            Text("Creating follow-up...")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                        .padding(24)
                        .background(.ultraThinMaterial)
                        .cornerRadius(16)
                    }
            }
        }
    }
}

#Preview {
    FollowUpFormView()
}

#Preview("With Data") {
    let vm = FollowUpFormViewModel()
    vm.toEmail = "boma@mail.com"
    vm.ccEmail = "daffa@mail.com"
    vm.emailSubject = "Azure Migration Follow-Up"
    vm.emailBody = "Dear Pak Bom,\n\nGimana ya pak?\n\nThanks,\nEileen"
    
    return FollowUpFormView(viewModel: vm)
}
