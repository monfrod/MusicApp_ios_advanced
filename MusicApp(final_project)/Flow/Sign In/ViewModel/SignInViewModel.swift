//
//  SignInViewModel.swift
//  BookMe
//
//  Created by Бағжан Артыкбаев on 26.03.2025.
//

import FirebaseCore
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class SignInViewModel {
    
    //    private let firebaseManager = FirebaseManager()
    var onSignInSuccess: (() -> Void)?
    var onSignInFailure: ((String) -> Void)?
    var router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    
//     MARK: - Sign In
    func signIn(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Успешный вход! UID: \(result?.user.uid ?? "Нет UID")")
                self.navigateToHome()
            }
        }
    }
    //
    //    
    //    // MARK: - Google
    //    func signInWithGoogle(presenting viewController: UIViewController) {
    //        guard let clientID = FirebaseApp.app()?.options.clientID else {
    //            print("Не удалось получить ID клиента для Google")
    //            return
    //        }
    //        
    //        let config = GIDConfiguration(clientID: clientID)
    //        GIDSignIn.sharedInstance.configuration = config
    //        
    //        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [weak self] result, error in
    //            if let error = error {
    //                self?.onSignInFailure?(error.localizedDescription)
    //                return
    //            }
    //            
    //            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
    //                self?.onSignInFailure?("Ошибка получение данных Google")
    //                return
    //            }
    //            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
    //            
    //            
    //            Auth.auth().signIn(with: credential) { authResult, error in
    //                if let error = error {
    //                    print("Firebase Auth Error \(error.localizedDescription)")
    //                    self?.onSignInFailure?("Firebase Auth Error \(error.localizedDescription)")
    //                }
    //                
    //                guard let uid = authResult?.user.uid else {
    //                    self?.onSignInFailure?("UID не найден")
    //                    return
    //                }
    //                
    //                let email = authResult?.user.email ?? ""
    //                let name = user.profile?.givenName ?? ""
    //                let surname = user.profile?.familyName ?? ""
    //                
    ////                let userData = UserData(name: name, surname: surname, dateOfBirth: "", email: email, password: "")
    //                
    //                self?.firebaseManager.saveUserInfoToFirestore(uid: uid, user: userData, competion: { result in
    //                    switch result {
    //                    case .success:
    //                        self?.onSignInSuccess?()
    //                    case .failure(let err):
    //                        self?.onSignInFailure?("Ошибка при сохранения данных Google \(err.localizedDescription)")
    //                    }
    //                })
    //                
    //            }
    //        }
    //    }
    //    
    //    
    //    // MARK: - Facebook
    //    func signInWithFacebook(from viewController: UIViewController) {
    //        let loginManager = LoginManager()
    //        loginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { result, error in
    //            if let error = error {
    //                self.onSignInFailure?(error.localizedDescription)
    //            } else if let result = result, !result.isCancelled {
    //                self.fetchFacebookUserProfile()
    //            } else {
    //                self.onSignInFailure?("Вход через Facebook отменен")
    //            }
    //        }
    //    }
    //    
    //    private func fetchFacebookUserProfile() {
    //        guard let token = AccessToken.current, !token.isExpired else {
    //            onSignInFailure?("Токен Facebook недоступен или истек")
    //            return
    //        }
    //        
    //        let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
    //        request.start { _, result, error in
    //            if let error = error {
    //                self.onSignInFailure?(error.localizedDescription)
    //            } else if let data = result as? [String: Any] {
    //                print("Данные профиля Facebook: \(data)")
    //                self.onSignInSuccess?()
    //            }
    //        }
//}
    func navigateToSignUp() {
        router.navigateToSignUp()
    }
    
    func navigateToHome() {
        router.navigateToMain()
    }
}
