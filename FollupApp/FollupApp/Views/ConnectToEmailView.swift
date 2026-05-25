//
//  ConnectToEmailView.swift
//  FollupApp
//
//  Created by Eileen Anindya on 25/05/26.
//

import SwiftUI

struct ConnectToEmailView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoading: Bool = false
    @State var showError: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 24) {
                Spacer()
                
                VStack(spacing: 24){
                    VStack(spacing: 8) {
                        Text("Connect your email")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.themeTypography)
                        
                        Text("Sign in to enable automated follow-up emails")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                                    
                    VStack(spacing: 12) {
                        VStack(alignment: .leading) {
                            Text("Email Address")
                                .foregroundColor(.themeTypography)
                            TextField("Enter your email", text: $username)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding(14)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.themeFormBackground)
                                )
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Password")
                                .foregroundColor(.themeTypography)
                            SecureField("Enter your password", text: $password)
                                .textContentType(.password)
                                .padding(14)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.themeFormBackground)
                                )
                        }
                    }
                }
                
                Spacer()
                                
                Button {
                    isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isLoading = false
                    }
                } label: {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Connect")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.themePrimary)
                    )
                    .foregroundColor(.white)
                }
                .disabled(username.isEmpty || password.isEmpty)
                .opacity(username.isEmpty || password.isEmpty ? 0.6 : 1)
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
            .alert("Invalid credentials", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please check your email and password.")
            }
        }
    }
}

#Preview {
    ConnectToEmailView()
}

#Preview("Filled") {
    ConnectToEmailView(username: "eileenanindya@mail.com", password: "eileen123")
}
