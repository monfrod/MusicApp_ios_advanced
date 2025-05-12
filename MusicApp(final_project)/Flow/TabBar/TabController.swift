import UIKit
import SwiftUI
import Combine

class TabController: UITabBarController {
    
    var mainRouter: MainRouter
    var appRouter: AppRouter
    let playerManager = SceneDelegate.playerManager
    
    private var miniPlayerHostingController: UIHostingController<AnyView>?
    private var miniPlayerView: UIView? {
        miniPlayerHostingController?.view
    }
    private var miniPlayerHeightConstraint: NSLayoutConstraint?
    private var cancellables = Set<AnyCancellable>() // Для хранения подписок

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
        self.setupMiniPlayer()
        self.observePlayerState()
    }

    private func setupTabs() {
        // Передаем playerManager в HomeView и другие представления вкладок
        let service = YandexApiServices()
        let homeVM = HomeViewModel(service: service, router: mainRouter)
        let homeView = HomeView(viewModel: homeVM, playerManager: playerManager).environmentObject(playerManager)
        let homeVC = createNav(title: "Home",
                               image: UIImage(named: "home"),
                               vc: CustomHostingController(shouldShowNavigationBar: false,
                                                           rootView: homeView))
        let exploreVM = ExploreViewModel(services: service)
        let exploreView = ExploreView(viewModel: exploreVM).environmentObject(playerManager) // Пример для другой вкладки
        let exploreVC = createNav(title: "Explore",
                                  image: UIImage(named: "search"),
                                 vc: CustomHostingController(shouldShowNavigationBar: false,
                                                             rootView: exploreView))

        let libraryView = LibraryView().environmentObject(playerManager) // Пример для другой вкладки
        let libraryVC = createNav(title: "Library",
                                  image: UIImage(named: "library"),
                                  vc: CustomHostingController(shouldShowNavigationBar: false,
                                                              rootView: libraryView))
        
        self.setViewControllers([homeVC, exploreVC, libraryVC], animated: true)
    }

    private func createNav(title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        vc.title = title
        return navController
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "tabBarBackground") ?? .black
        
        let itemAppearance = UITabBarItemAppearance()
        // Selected state
        itemAppearance.selected.iconColor = UIColor.white
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        // Normal state
        itemAppearance.normal.iconColor = UIColor.gray
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.tabBar.tintColor = .white // Для индикатора выбранной вкладки (если не переопределен itemAppearance)
    }

    private func setupMiniPlayer() {
        // showPlayerDetail теперь управляется через TabController
        let miniPlayerSwiftUIView = MiniPlayerView(
            onTapAction: { [weak self] in
                self?.presentPlayerDetail()
            }
        ).environmentObject(playerManager)
        
        miniPlayerHostingController = UIHostingController(rootView: AnyView(miniPlayerSwiftUIView))
        guard let miniPlayerView = self.miniPlayerView else { return }
        
        miniPlayerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(miniPlayerView)

        NSLayoutConstraint.activate([
            miniPlayerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            miniPlayerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            miniPlayerView.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: 0),
        ])
        miniPlayerHeightConstraint = miniPlayerView.heightAnchor.constraint(equalToConstant: 64)
        miniPlayerHeightConstraint?.isActive = true
        
        miniPlayerView.isHidden = true // Изначально скрыт
    }

    private func observePlayerState() {
        playerManager.$currentTrack
            .receive(on: DispatchQueue.main)
            .sink { [weak self] track in
                guard let self = self else { return }
                let shouldShow = track != nil
                print("TabController: observePlayerState - currentTrack is \(track == nil ? "nil" : "NOT nil"). ShouldShow: \(shouldShow)")
                // Анимация появления/исчезновения
                UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
                    self.miniPlayerView?.isHidden = !shouldShow
                    self.miniPlayerView?.alpha = shouldShow ? 1.0 : 0.0
                    self.view.layoutIfNeeded()
                })
            }
            .store(in: &cancellables)
    }

    func presentPlayerDetail() {
        // Создаем PlayerDetailView и передаем ему playerManager
//        let playerDetailSwiftUIView = PlayerDetailView(track: playerManager.$currentTrack).environmentObject(playerManager)
//        let hostingController = UIHostingController(rootView: playerDetailSwiftUIView)
//        hostingController.modalPresentationStyle = .pageSheet // или .formSheet, .fullScreen
//        
//        // Убедимся, что PlayerDetailView занимает весь экран, если это .pageSheet или .formSheet
////        if #available(iOS 15.0, *) {
////            if let sheet = hostingController.sheetPresentationController {
////                sheet.detents = [.large()] // Только большой размер
////                sheet.prefersGrabberVisible = true
////            }
////        }
//        self.present(hostingController, animated: true, completion: nil)
    }
}
