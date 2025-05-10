//
//  Main.swift
//  BookMe
//
//  Created by yunus on 06.04.2025.
//
import UIKit

final class MainRouter {
    
    var router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func createMainInterface() -> UITabBarController {
        let tabController = TabController(mainRouter: self, appRouter: router)
        return tabController
    }
    
}
