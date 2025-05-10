//
//  SignInView.swift
//  MusicApp(final_project)
//
//  Created by yunus on 03.05.2025.
//
import SwiftUI

struct SignInView: View {
    
    let viewModel: SignInViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text("Login to your account")
                .font(.system(size: 35))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(.top, 10)
            emailTextField()
            passwordTextField()
                .padding(.bottom, 30)
            loginButton()
            Spacer()
            goSignUp()
        }
        .background(Color.customGray)
    }
    
    @ViewBuilder
    func emailTextField() -> some View {
        HStack {
            Image(systemName: "envelope")
                .foregroundColor(.gray)
                .frame(width: 20)
            
            TextField("Email", text: $email)
                .foregroundColor(.white)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .padding(.horizontal)
    }
    
    func passwordTextField() -> some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.gray)
                .frame(width: 20)
            
            if isPasswordVisible {
                TextField("Password", text: $password)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
            } else {
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
            }
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .padding(.horizontal)
    }
    func goSignUp() -> some View {
        HStack {
            Text("Don't have an account?")
                .foregroundStyle(.white)
            Button("Sign Up") {
                viewModel.navigateToSignUp()
            }
            .foregroundColor(.skyBlue)
        }
        .padding(.bottom, 30)
    }
    func loginButton() -> some View {
        Button(action: {
            viewModel.signIn(email: email, password: password)
        }) {
            Text("Log in with a password")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(30)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel(router: AppRouter()))
}
