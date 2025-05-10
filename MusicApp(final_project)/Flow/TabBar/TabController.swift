//
//  TabController.swift
//  BookMe
//
//  Created by yunus on 11.03.2025.
//
import UIKit
import SwiftUI

class TabController: UITabBarController {
    
    var mainRouter: MainRouter
    var appRouter: AppRouter
    
    init(mainRouter: MainRouter, appRouter: AppRouter) {
        self.mainRouter = mainRouter
        self.appRouter = appRouter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.tabBar.barTintColor = .lightGray
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        self.tabBar.standardAppearance = appearance
    }
    private func setupTabs(){
//        let service = FirestoreServiceImpl()
//        let homeVM = HomeViewModel(router: mainRouter)
        let homeVC = createNav(title: "Home",
                               image: UIImage(named: "home"),
                               vc: CustomHostingController(shouldShowNavigationBar: false,
                                                           rootView: HomeView()))
        
        let reviewVC = createNav(title: "Explore",
                                 image: UIImage(named: "search"),
                                 vc: CustomHostingController(shouldShowNavigationBar: false, rootView: ExploreView()))
//        let profileVM = ProfileViewModel(router: appRouter)
        let hostingView = CustomHostingController(shouldShowNavigationBar: false,
                                                  rootView: LibraryView())
        let profileVC = createNav(title: "Library",
                                  image: UIImage(named: "library"),
                                  vc: hostingView)
        
        
        self.setViewControllers([homeVC, reviewVC, profileVC], animated: true)
    }
    private func createNav(title: String, image: UIImage?, vc: UIViewController)-> UIViewController{
        
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        
        vc.title = title
        
        return vc
    }
}
