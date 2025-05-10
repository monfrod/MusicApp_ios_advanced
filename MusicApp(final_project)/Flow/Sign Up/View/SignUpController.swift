//
//  SignUpController.swift
//  BookMe
//
//  Created by Бағжан Артыкбаев on 22.03.2025.
//

import SwiftUI
import FirebaseAuth

//class SignUpController: UIViewController {
//
//    let viewModel: SignUpViewModel
//
//    init(viewModel: SignUpViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initialize()
//
//        viewModel.onSuccess = { [weak self] in
//            print("Успешная регестрация")
//            self?.navigateToHome()
//        }
//
//        viewModel.onError = { [weak self] error in
//            print(error)
//            AlertManager.showSignUpFailureAlert(in: self!, error: error)
//
//        }
//    }
//
//    // MARK: - Private UIConstant
//    private enum UIConstant {
//        static let spacing: CGFloat = 20
//        static let contentInset: CGFloat = 16
//        static let stackViewForTop: CGFloat = 20
//        static let RegisterButtonToViewBottom: CGFloat = 70
//        static let registerButtomHeight: CGFloat = 56
//    }
//
//    // MARK: - Private properties
//    private let nameTF = CustomInputView(fieldType: .username, title: "Name", placeholder: "Name")
//    private let surnameTF = CustomInputView(fieldType: .username, title: "Surname", placeholder: "Surname")
//    private let dateOfBirthTF = CustomInputView(fieldType: .dateOfBirth, title: "Date of birth", placeholder: "dd/mm/yy")
//    private let emailTF = CustomInputView(fieldType: .email, title: "Email", placeholder: "Email")
//    private let passwordTF = CustomInputView(fieldType: .password, title: "Password", placeholder: "Create a password")
//    private let repeatPasswordTF = CustomInputView(fieldType: .password, title: "Password", placeholder: "Repeat your password")
//
//    private let registerButton = CustomButton(title: "Register", hasBackground: true, fontSize: .big)
//
//    private lazy var stackViewForTF: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [nameTF, surnameTF, dateOfBirthTF, emailTF, passwordTF, repeatPasswordTF])
//        stack.spacing = UIConstant.spacing
//        stack.axis = .vertical
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
//}
//
//// MARK: - Private method
//private extension SignUpController {
//    func initialize() {
//        self.view.backgroundColor = .white
//        self.navigationItem.titleView = LogoView()
//        self.navigationController?.navigationBar.tintColor = UIColor(hex: "6A46A9")
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        view.addSubview(stackViewForTF)
//        NSLayoutConstraint.activate([
//            stackViewForTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstant.stackViewForTop),
//            stackViewForTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstant.contentInset),
//            stackViewForTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstant.contentInset)
//        ])
//
//        view.addSubview(registerButton)
//        NSLayoutConstraint.activate([
//            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstant.contentInset),
//            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstant.contentInset),
//            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIConstant.RegisterButtonToViewBottom),
//
//            registerButton.heightAnchor.constraint(equalToConstant: UIConstant.registerButtomHeight)
//        ])
//
//        //MARK: - Action for button
//        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
//    }
//
//    func navigateToHome() {
//        viewModel.navigateToHome()
//    }
//
//    //MARK: - Selector
//    @objc func handleRegister() {
//        viewModel.name = nameTF.text ?? ""
//        viewModel.surname = surnameTF.text ?? ""
//        viewModel.dateOfBirth = dateOfBirthTF.text ?? ""
//        viewModel.email = emailTF.text ?? ""
//        viewModel.password = passwordTF.text ?? ""
//        viewModel.repeatPassword = repeatPasswordTF.text ?? ""
//
//        viewModel.registerUser()
//    }
//
//    @objc func keyboardWillShow(_ notification: Notification) {
//        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//
//        if let activeTextField = view.findFirstResponder() {
//            let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: view)
//            let keyboardTop = view.frame.height - keyboardFrame.height
//
//            if textFieldFrame.maxY > keyboardTop {
//                let offset = textFieldFrame.maxY - keyboardTop + 20
//                view.frame.origin.y = -offset
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(_ notification: Notification) {
//        view.frame.origin.y = 0
//    }
//
//}
//
//// MARK: - Extension for UIView
//extension UIView {
//    func findFirstResponder() -> UIView? {
//        if self.isFirstResponder {
//            return self
//        }
//        for subview in subviews {
//            if let firstResponder = subview.findFirstResponder() {
//                return firstResponder
//            }
//        }
//        return nil
//    }
//}
struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    @State private var errorMessage: String?
    @State private var showAlert: Bool = false
    @State private var isLoading: Bool = false
    
    let viewModel: SignUpViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Repeat Password", text: $repeatPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if isLoading {
                ProgressView()
            }
            
            Button(action: register) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
    }
    
    private func register() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !repeatPassword.isEmpty else {
            errorMessage = "Please fill all fields."
            showAlert = true
            return
        }
        
        guard password == repeatPassword else {
            errorMessage = "Passwords do not match."
            showAlert = true
            return
        }
        
        isLoading = true
        viewModel.createUser(email: email, password: password)
        viewModel.navigateToHome()
        isLoading = false
    }
}
