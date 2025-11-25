import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginMessage = ""

    var body: some View {
        NavigationStack { // Needed for NavigationLink to work
            VStack(spacing: 20) {
                // App title
                Text("Welcome to Movie Recommender")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)

                // Email and Password fields
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)     // Prevents automatic capitalization
                        .disableAutocorrection(true)   // Optional: disables autocorrect

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                .padding(.horizontal, 30)

                // Login button
                Button(action: handleLogin) {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)

                // Login message
                Text(loginMessage)
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding(.top, 5)

                // Navigation link to Sign-Up page
                NavigationLink(destination: SignUpView()) {
                    Text("Create Account")
                        .foregroundColor(.blue)
                        .underline()
                }
                .padding(.top, 10)

                Spacer()
            }
            .padding(.top, 100)
        }
    }

    // MARK: - Login Logic
    func handleLogin() {
        if email.isEmpty || password.isEmpty {
            loginMessage = "Please fill in all fields"
        } else if email == "test@example.com" && password == "password123" {
            loginMessage = "Login successful!"
        } else {
            loginMessage = "Invalid email or password"
        }
    }
}

#Preview {
    ContentView()
}
