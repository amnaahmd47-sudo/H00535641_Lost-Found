//
//  LoginView.swift
//  H00535641_Lost&Found
//

import SwiftUI

struct LoginView: View {
    // saved data (AppStorage)
    @AppStorage("userEmail") private var userEmail: String = ""
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @AppStorage("rememberMe") private var rememberMe: Bool = true

    // user input
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false

    // alert
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

    var body: some View {
        VStack {
            VStack(spacing: 16) {

                // logo and title
                Image("AppLogo")
                    .resizable()
                    .frame(width: 84, height: 84)
                    .cornerRadius(20)
                    .padding(.top, 40)

                Text("Welcome back")
                    .font(.largeTitle)
                    .bold()

                Text("Log in with your HCT student email")
                    .foregroundColor(.secondary)
                    .padding(.bottom, 12)

                // email field
                VStack(alignment: .leading, spacing: 6) {
                    Text("Student Email")
                        .font(.subheadline)
                        .bold()

                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.secondary)
                        TextField("name@hct.ac.ae", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(12)
                }

                // password field
                VStack(alignment: .leading, spacing: 6) {
                    Text("Password")
                        .font(.subheadline)
                        .bold()

                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.secondary)

                        // show or hide password
                        if showPassword {
                            TextField("Password", text: $password)
                                .autocapitalization(.none)
                        } else {
                            SecureField("Password", text: $password)
                        }

                        Button {
                            showPassword = !showPassword
                        } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(12)
                }

                // remember me and forgot password
                Toggle("Remember me", isOn: $rememberMe)

                HStack {
                    Spacer()

                    Button("Forgot password?") {
                        showMessage(title: "Forgot Password",
                                    message: "This app works only on your phone. Just enter any password with at least 6 characters.")
                    }
                    .font(.subheadline)
                }

                // Log In button
                Button {
                    logIn()
                } label: {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.top, 8)

                // sign up
                HStack(spacing: 4) {
                    Text("Don't have an account?")
                        .foregroundColor(.secondary)
                    Button("Sign Up") {
                        showMessage(title: "No Sign Up Needed",
                                    message: "Enter your HCT email and a password to start using the app.")
                    }
                    .bold()
                }
                .font(.subheadline)
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .onAppear {
            // fill saved email
            email = userEmail
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    // check inputs then login
    private func logIn() {
        let cleanEmail = email.trimmingCharacters(in: .whitespaces).lowercased()

        // empty fields
        if cleanEmail.isEmpty || password.isEmpty {
            showMessage(title: "Missing Information",
                        message: "Please enter your email and password.")
            return
        }

        // must be hct email
        if !cleanEmail.hasSuffix("@hct.ac.ae") {
            showMessage(title: "Invalid Email",
                        message: "Please use your HCT email (name@hct.ac.ae).")
            return
        }

        // password length
        if password.count < 6 {
            showMessage(title: "Short Password",
                        message: "Password must be at least 6 characters.")
            return
        }

        // save email only and go to home
        userEmail = cleanEmail
        isLoggedIn = true
    }

    // show alert
    private func showMessage(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

#Preview {
    LoginView()
}
