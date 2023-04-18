//
//  TabBarCoordinator.swift
//  ArtDeFond
//
//  Created by developer on 17.08.2022.
//

import Foundation
import UIKit
import FirebaseAuth
import Swinject

class TabBarCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        setupTabBar()
    }

    func setupTabBar() {
        let tabBarController = UITabBarController()
        var controllers: [UINavigationController] = []

        for tab in Tab.allCases {
            let homeNavigationController = UINavigationController()
            homeNavigationController.tabBarItem = tab.getTabBarItem()
            controllers.append(homeNavigationController)

            let tabCoordinator = tab.getCoordinator(navigationController: homeNavigationController)

            tabCoordinator.container = container
            parentCoordinator?.children.append(tabCoordinator)
            tabCoordinator.start()
        }

        tabBarController.tabBar.tintColor = Constants.Colors.darkRed
        tabBarController.tabBar.unselectedItemTintColor = Constants.Colors.middleRed
        tabBarController.tabBar.backgroundColor = .white
        
        tabBarController.viewControllers = controllers
        navigationController.pushViewController(tabBarController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)

    }

}

enum Tab: CaseIterable {
    case feed, search, upload, notifications, profile

    func getTabBarItem() -> UITabBarItem {
        let tabBarItem = UITabBarItem()
        switch self {
        case .feed:
            tabBarItem.title = "Лента"
            tabBarItem.image = Constants.Icons.house
        case .search:
            tabBarItem.title = "Поиск"
            tabBarItem.image = Constants.Icons.search
        case .profile:
            tabBarItem.title = "Профиль"
            tabBarItem.image = Constants.Icons.profile
        case .upload:
            tabBarItem.title = nil
            tabBarItem.image = Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal)
        case .notifications:
            tabBarItem.title = "Уведомления"
            tabBarItem.image = Constants.Icons.bell
        }
        return tabBarItem
    }

    func getCoordinator(navigationController: UINavigationController) -> Coordinator {
        switch self {
        case .feed:
            return FeedCoordinator(navigationController: navigationController)
        case .profile:
            return ProfileCoordinator(navigationController: navigationController)
        case .search:
            return SearchCoordinator(navigationController: navigationController)
        case .upload:
            return UploadPhotoCoordinator(navigationController: navigationController)
        case .notifications:
            return NotificationsCoordinator(navigationController: navigationController)
        }
    }
}



//final class TabBarCoordinator: Coordinator {
//    var rootViewController: UINavigationController
//
//    var rootTabBarController: UITabBarController
//
//    var childCoordinators: [Coordinator]
//
//    private let isAuth: Bool
//
//    init(rootViewController: UINavigationController){
//        self.rootViewController = rootViewController
//        self.childCoordinators = []
//        self.rootTabBarController = UITabBarController()
//
//        self.isAuth = AuthService.shared.isAuthed()
//        observeNotificationCenter()
//        setup(isAuth: isAuth)
//    }
//
//    private func observeNotificationCenter() {
//        NotificationCenter.default.addObserver(self, selector: #selector(setLoginViewControllers), name: NSNotification.Name("InterestViewController.signUp.succes.ArtDeFond"), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(goToFeedTab), name: NSNotification.Name("CostViewModel.uploadPicture.success.ArtDeFond"), object: nil)
//    }
//
//    private func setup(isAuth: Bool) {
//        setupTabBarController()
//    }
//
//    private func setupTabBarController() {
//        let firstTab = setupFirstTab()
//        let secondTab = setupSecondTab()
//        let thirdTab = setupThirdTab()
//        let fouthTab = setupFouthTab()
//        let fifthTab = setupFifthTab()
//        var controllers = [firstTab, secondTab, thirdTab, fouthTab, fifthTab]
//        controllers = controllers.map { UINavigationController(rootViewController: $0)}
//
//        rootTabBarController.tabBar.tintColor = Constants.Colors.darkRed
//        rootTabBarController.tabBar.unselectedItemTintColor = Constants.Colors.middleRed
//        rootTabBarController.tabBar.backgroundColor = .white
//    }
//
//    private func setupFirstTab() -> UIViewController{
//        let seacrhVC = SearchViewController()
//        seacrhVC.tabBarItem.image = Constants.Icons.search
//        seacrhVC.tabBarItem.title = "Поиск"
//        return seacrhVC
//    }
//
//    private func setupSecondTab() -> UIViewController{
//        let feedVC = FeedViewController(viewModel: FeedViewModel())
//        feedVC.tabBarItem.image = Constants.Icons.house
//        feedVC.tabBarItem.title = "Лента"
//        return feedVC
//    }
//
//    private func setupThirdTab() -> UIViewController{
//        let uploadPhotoVC = isAuth ? UploadPhotoViewController(viewModel: .init()) : AuthViewController()
//        uploadPhotoVC.tabBarItem = UITabBarItem(title: nil,
//                                                image: Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal),
//                                                tag: 0)
//        uploadPhotoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
//                                                            left: 0,
//                                                            bottom: -7,
//                                                            right: 0)
//        return uploadPhotoVC
//    }
//
//    private func setupFouthTab() -> UIViewController{
//        let notificationVC = isAuth ? NotificationsViewController(viewModel: NotificationsViewModel()) : AuthViewController()
//        notificationVC.tabBarItem.image = Constants.Icons.bell
//        notificationVC.tabBarItem.title = "Уведомления"
//        return notificationVC
//    }
//
//    private func setupFifthTab() -> UIViewController{
//        let viewModel = ProfileViewModel()
//        let provileVC: UIViewController = isAuth ? ProfileViewController(viewModel: viewModel) : AuthViewController()
//        provileVC.tabBarItem.image = Constants.Icons.profile
//        provileVC.tabBarItem.title = "Профиль"
//        return provileVC
//    }
//
//    func start() {
//        rootViewController.pushViewController(rootTabBarController, animated: true)
//    }
//
//    @objc
//      func goToFeedTab(){
//          rootTabBarController.selectedIndex = 0
//      }
//
//
//    @objc
//    func setLoginViewControllers(){
//        let seacrhVC = SearchViewController()
//        seacrhVC.tabBarItem.image = Constants.Icons.search
//        seacrhVC.tabBarItem.title = "Поиск"
//
//        let feedVC = FeedViewController(viewModel: FeedViewModel())
//        feedVC.tabBarItem.image = Constants.Icons.house
//        feedVC.tabBarItem.title = "Лента"
//
//        let uploadPhotoVC = UploadPhotoViewController(viewModel: .init())
//
//        uploadPhotoVC.tabBarItem = UITabBarItem(title: nil,
//                                                image: Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal),
//                                                tag: 0)
//        uploadPhotoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
//                                                            left: 0,
//                                                            bottom: -7,
//                                                            right: 0)
//
//        let notificationVC = NotificationsViewController(viewModel: NotificationsViewModel())
//        notificationVC.tabBarItem.image = Constants.Icons.bell
//        notificationVC.tabBarItem.title = "Уведомления"
//
//        let provileVC = ProfileViewController(viewModel: ProfileViewModel())
//        provileVC.tabBarItem.image = Constants.Icons.profile
//        provileVC.tabBarItem.title = "Профиль"
//
//        let controllers = [feedVC, seacrhVC, uploadPhotoVC, notificationVC, provileVC]
//
//        rootTabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
//    }
//}
//
//extension TabBarCoordinator: AuthViewContollerDelegate{
//    func DidLogin() {
//        let seacrhVC = SearchViewController()
//        seacrhVC.tabBarItem.image = Constants.Icons.search
//        seacrhVC.tabBarItem.title = "Поиск"
//
//        let feedVC = FeedViewController(viewModel: FeedViewModel())
//        feedVC.tabBarItem.image = Constants.Icons.house
//        feedVC.tabBarItem.title = "Лента"
//
//        let uploadPhotoVC = UploadPhotoViewController(viewModel: .init())
//
//        uploadPhotoVC.tabBarItem = UITabBarItem(title: nil,
//                                              image: Constants.Icons.bigPlus.withRenderingMode(.alwaysOriginal),
//                                              tag: 0)
//        uploadPhotoVC.tabBarItem.imageInsets = UIEdgeInsets(top: 7,
//                                                          left: 0,
//                                                          bottom: -7,
//                                                          right: 0)
//
//        let notificationVC = NotificationsViewController(viewModel: NotificationsViewModel())
//        notificationVC.tabBarItem.image = Constants.Icons.bell
//        notificationVC.tabBarItem.title = "Уведомления"
//
//        let provileVC = ProfileViewController(viewModel: ProfileViewModel())
//        provileVC.tabBarItem.image = Constants.Icons.profile
//        provileVC.tabBarItem.title = "Профиль"
//
//        let controllers = [feedVC, seacrhVC, uploadPhotoVC, notificationVC, provileVC]
//
//        rootTabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
//    }
//}
