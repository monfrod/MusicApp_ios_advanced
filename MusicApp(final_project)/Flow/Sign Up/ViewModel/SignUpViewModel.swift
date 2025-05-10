//
//  SignUpViewModel.swift
//  BookMe
//
//  Created by Бағжан Артыкбаев on 26.03.2025.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewModel {
    
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    // MARK: - Properties
    var name: String = ""
    var surname: String = ""
    var dateOfBirth: String = ""
    var email: String = ""
    var password: String = ""
    var repeatPassword: String = ""
    
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
//    private let firebaseManager = FirebaseManager()
    
    // MARK: - Method
    func isValidEmail(_ email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    func validateFields() -> Bool {
        guard !name.isEmpty, !surname.isEmpty, !dateOfBirth.isEmpty,
              !email.isEmpty, !password.isEmpty, !repeatPassword.isEmpty else {
            onError?("Please fill in all fields!")
            return false
        }
        
        guard isValidEmail(email) else {
            onError?("Invalid email format.")
            return false
        }
        
        guard isValidPassword(password) else {
            onError?("Password must be at least 6 charecters long.")
            return false
        }
        
        guard password == repeatPassword else {
            onError?("Password do not match.")
            return false
        }
        
        return true
    }
    
//    func registerUser() {
//        guard validateFields() else { return }
//        
//        let userData = UserData(
//            name: name,
//            surname: surname,
//            dateOfBirth: dateOfBirth,
//            email: email,
//            password: password
//        )
//        
//        firebaseManager.registerNewUser(user: userData) { [weak self] result in
//            switch result {
//            case .success:
//                self?.onSuccess?()
//            case .failure(let err):
//                self?.onError?(err.localizedDescription)
//            }
//        }
//    }
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                
            } else {
                // Optional: Save user name in Firestore
                print("User created: \(result?.user.uid ?? "")")
            }
        }
    }
    
    func navigateToHome() {
        router.navigateToMain()
    }
    
}
