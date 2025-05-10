//
//  SignInController.swift
//  BookMe
//
//  Created by Бағжан Артыкбаев on 21.03.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

//class SignInController: UIViewController {
//    
//    let viewModel: SignInViewModel
//
//    init(viewModel: SignInViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    // MARK: - LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initialize()
//        viewModel.onSignInSuccess = { [weak self] in
//            print("Успешный вход!")
//            self?.navigateToHome()
//        }
//        
//        viewModel.onSignInFailure = { error in
//            AlertManager.showSignInFailureAlert(in: self, error: error)
//            print(error)
//        }
//    }
//    
//    //MARK: - Private UIConstant
//    private enum UIConstant {
//        static let spacingForStackViewForSocial: CGFloat = 16
//        static let contentInset: CGFloat = 16
//        static let contentInsetForSocialButton: CGFloat = 67
//        static let contentInsetforgotPasswordTextButton: CGFloat = 28
//        static let topToStackViewForTF: CGFloat = 150
//        static let stackViewForTFToforgotPasswordTextButtonOffset: CGFloat = 8
//        static let forgotPasswordTextButtonToLoginButtonOffset: CGFloat = 76
//        static let loginButtonTostackViewForSocialOffset: CGFloat = 78
//        static let heightLoginButton: CGFloat = 56
//        static let stackViewForSocialToTryAsAGuestTextButtonOffset: CGFloat = 20
//        static let stackViewForRegisterToViewButtom: CGFloat = 30
//        static let spacingForStackViewForRegister: CGFloat = 10
//    }
//    
//    // MARK: - Private properties
//    private let emailTF = CustomInputView(fieldType: .email, title: "Email", placeholder: "Email")
//    private let passwordTF = CustomInputView(fieldType: .password, title: "Password", placeholder: "Password")
//    
//    private let forgotPWButton = CustomButton(title: "Forgot your password?", fontSize: .small)
//    private let tryAsAGuestButton = CustomButton(title: "Try as a guest", fontSize: .small)
//    private let registerNow = CustomButton(title: "Register Now", fontSize: .small)
//    private let loginButton = CustomButton(title: "Login", hasBackground: true, fontSize: .big, opacity: true)
//    
//    private let googleButton = SocialButtonView(image: UIImage(named: "google"))
//    private let appleButton = SocialButtonView(image: UIImage(named: "apple"))
//    private let facebookButton = SocialButtonView(image: UIImage(named: "facebook"))
//    
//    private let dontHaveAnAccountLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Don't have an account?"
//        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        label.textColor = .black
//        return label
//    }()
//    
//    private lazy var stackViewForTF: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [self.emailTF, self.passwordTF])
//        stack.axis = .vertical
//        stack.spacing = UIConstant.spacingForStackViewForSocial
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
//    
//    private lazy var stackViewForSocial: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [googleButton, appleButton, facebookButton])
//        stack.axis = .horizontal
//        stack.distribution = .fillEqually
//        stack.spacing = UIConstant.spacingForStackViewForSocial
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
//    
//    private lazy var stackViewForRegister: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [dontHaveAnAccountLabel, registerNow])
//        stack.axis = .horizontal
//        stack.spacing = UIConstant.spacingForStackViewForRegister
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
//    
//}
//
//// MARK: - Private method
//private extension SignInController {
//    func initialize() {
//        self.view.backgroundColor = .white
//        self.navigationItem.titleView = LogoView()
//        
//        // Constraint
//        view.addSubview(stackViewForTF)
//        NSLayoutConstraint.activate([
//            stackViewForTF.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstant.topToStackViewForTF),
//            stackViewForTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstant.contentInset),
//            stackViewForTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstant.contentInset)
//        ])
//        
//        view.addSubview(forgotPWButton)
//        NSLayoutConstraint.activate([
//            forgotPWButton.topAnchor.constraint(equalTo: stackViewForTF.bottomAnchor, constant: UIConstant.stackViewForTFToforgotPasswordTextButtonOffset),
//            forgotPWButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstant.contentInsetforgotPasswordTextButton)
//        ])
//        
//        view.addSubview(loginButton)
//        NSLayoutConstraint.activate([
//            loginButton.topAnchor.constraint(equalTo: forgotPWButton.bottomAnchor, constant: UIConstant.forgotPasswordTextButtonToLoginButtonOffset),
//            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstant.contentInset),
//            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstant.contentInset),
//            loginButton.heightAnchor.constraint(equalToConstant: UIConstant.heightLoginButton)
//        ])
//        
//        view.addSubview(stackViewForSocial)
//        NSLayoutConstraint.activate([
//            stackViewForSocial.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: UIConstant.loginButtonTostackViewForSocialOffset),
//            stackViewForSocial.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstant.contentInsetForSocialButton),
//            stackViewForSocial.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstant.contentInsetForSocialButton),
//            stackViewForSocial.heightAnchor.constraint(equalToConstant: 56)
//        ])
//        
//        view.addSubview(tryAsAGuestButton)
//        NSLayoutConstraint.activate([
//            tryAsAGuestButton.topAnchor.constraint(equalTo: stackViewForSocial.bottomAnchor, constant: UIConstant.stackViewForSocialToTryAsAGuestTextButtonOffset),
//            tryAsAGuestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//        
//        view.addSubview(stackViewForRegister)
//        NSLayoutConstraint.activate([
//            stackViewForRegister.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackViewForRegister.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIConstant.stackViewForRegisterToViewButtom)
//        ])
//        
//        //MARK: - Action for button
//        registerNow.addTarget(self, action: #selector(registerNowTapped), for: .touchUpInside)
//        tryAsAGuestButton.addTarget(self, action: #selector(tryAsAGuestTapped), for: .touchUpInside)
//        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//        
//        emailTF.textField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)
//        passwordTF.textField.addTarget(self, action: #selector(updateLoginButtonState), for: .editingChanged)
//        
//        //MARK: - Gesture
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tapGesture.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGesture)
//        
//        let facebookTapGesture = UITapGestureRecognizer(target: self, action: #selector(facebookLoginTapped))
//        facebookButton.addGestureRecognizer(facebookTapGesture)
//        
//        let googleTapGesture = UITapGestureRecognizer(target: self, action: #selector(googleSignInTapped))
//        googleButton.addGestureRecognizer(googleTapGesture)
//    }
//    
//    func navigateToHome() {
//        
//    }
//    
//    //MARK: - Selector
//    @objc func registerNowTapped() {
//        viewModel.navigateToSignUp()
//    }
//    
//    @objc func tryAsAGuestTapped() {
//        viewModel.navigateToHome()
//    }
//    
//    @objc func loginButtonTapped() {
//        guard let email = emailTF.text, !email.isEmpty,
//              let password = passwordTF.text, !password.isEmpty else {
//            
//            AlertManager.showSignInFailureAlert(in: self, error: "Please fill in all fields!")
//            return
//        }
//        
//        viewModel.signIn(email: email, password: password)
//        viewModel.navigateToHome()
//        
//    }
//    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//    
//    @objc func facebookLoginTapped() {
//        viewModel.signInWithFacebook(from: self)
//    }
// 
//    @objc func googleSignInTapped() {
//        viewModel.signInWithGoogle(presenting: self)
//    }
//    
//    @objc func updateLoginButtonState() {
//        if let emailText = emailTF.text, !emailText.isEmpty, let passwordText = passwordTF.text, !passwordText.isEmpty {
//            loginButton.backgroundColor = UIColor(hex: "6A46A9")
//            loginButton.setTitleColor(.white, for: .normal)
//        } else {
//            loginButton.backgroundColor = UIColor(hex: "6A46A933")
//            loginButton.setTitleColor(UIColor(hex: "6A46A9"), for: .normal)
//        }
//    }
//    
//}
struct Onboarding: View {
    
    let router: AppRouter
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            // Заголовок
            Text("Let's get you in")
                .font(.system(size: 50))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            Spacer()
            
            // Кнопка входа
            Button(action: {
                // Действие при входе
            }) {
                Text("Log in with a password")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(30)
            }
            .padding(.horizontal)
            
            // Нижняя часть с текстом и кнопкой (HStack)
            HStack {
                Text("Don't have an account?")
                    .foregroundStyle(.white)
                Button("Sign Up") {
                    // Переход к регистрации
                }
                .foregroundColor(.skyBlue)
            }
            .padding(.bottom, 30)
        }
        .background(Color.customGray)
    }
}

#Preview {
    Onboarding(router: AppRouter())
}
