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
        self.configureTabBarAppearance()
    }

    private func setupTabs() {
        let homeVC = createNav(title: "Home",
                               image: UIImage(named: "home"),
                               vc: CustomHostingController(shouldShowNavigationBar: false,
                                                           rootView: HomeView()))
        
        let reviewVC = createNav(title: "Explore",
                                 image: UIImage(named: "search"),
                                 vc: CustomHostingController(shouldShowNavigationBar: false,
                                                             rootView: ExploreView()))

        let profileVC = createNav(title: "Library",
                                  image: UIImage(named: "library"),
                                  vc: CustomHostingController(shouldShowNavigationBar: false,
                                                              rootView: LibraryView()))
        
        self.setViewControllers([homeVC, reviewVC, profileVC], animated: true)
    }

    private func createNav(title: String, image: UIImage?, vc: UIViewController) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        vc.title = title
        return vc
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        // Text and icon colors
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.tabBar.tintColor = .white
    }
}
