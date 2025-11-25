//
//  signupView.swift
//  MovieRecApp
//
//  Created by csuftitan on 11/24/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var message = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal, 30)

            Button(action: handleSignUp) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)

            Text(message)
                .foregroundColor(.red)
                .font(.subheadline)
                .padding(.top, 5)

            Spacer()
        }
        .padding(.top, 100)
    }

    func handleSignUp() {
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            message = "Please fill in all fields"
        } else if password != confirmPassword {
            message = "Passwords do not match"
        } else {
            message = "Account created successfully!"
        }
    }
}

#Preview {
    SignUpView()
}
