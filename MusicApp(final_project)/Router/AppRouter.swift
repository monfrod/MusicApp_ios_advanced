//
//  AppRouter.swift
//  MusicApp(final_project)
//
//  Created by yunus on 29.04.2025.
//


import UIKit
import SwiftUI

final class AppRouter {
    
    var rootVC: UINavigationController?
    
    // Инициализация начального экрана
    func start() {
        if UserDefaults.standard.bool(forKey: K().seeOnboarding) {
            navigateToMain()
        } else {
            navigateToOnboarding()
        }
        rootVC = UINavigationController(rootViewController: UIViewController())
    }
    // Навигация на экран логина
    func navigateToSignIn() {
        let signInVM = SignInViewModel(router: self)
        let signInController = SignInView(viewModel: signInVM)
        rootVC?.pushViewController(UIHostingController(rootView: signInController), animated: true)
    }
    
    func navigateToSignUp() {
        let signUpVM = SignUpViewModel(router: self)
        let signUpController = SignUpView(viewModel: signUpVM)
        rootVC?.pushViewController(UIHostingController(rootView: signUpController), animated: true)
    }
    
    // Навигация на главный экран после успешной авторизации
    func navigateToMain() {
        let mainRouter = MainRouter(router: self)
        let mainTabBar = mainRouter.createMainInterface()
        rootVC?.setViewControllers([mainTabBar], animated: true)
        rootVC?.isNavigationBarHidden = true
    }
    
    // Навигация обратно к онбордингу
    func navigateToOnboarding() {
//        let onboardingVM = OnboardingViewModel(router: self)
        let onboardingVC = UIHostingController(rootView: WelcomeScreen())
        rootVC?.pushViewController(onboardingVC, animated: true)
    }
}
