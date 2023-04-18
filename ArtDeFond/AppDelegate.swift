//
//  AppDelegate.swift
//  ArtDeFond
//
//  Created by developer on 10.08.2022.
//

import UIKit
import Firebase
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appCoordinator: AppCoordinator?
    var window: UIWindow?
    
    private let container = Container()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        

        FirebaseApp.configure()
        registerMockDependencies()
        
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.container = container
        appCoordinator?.start()
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}


extension AppDelegate {
    private func registerDependencies() {
        container.register(PictureServiceDescription.self) { _ in
            return PictureService()
        }
        
        container.register(AuthServiceDescription.self) { _ in
            return AuthService()
        }
    }

    private func registerMockDependencies() {
        container.register(PictureServiceDescription.self) { _ in
            return MockPictureService()
        }
        
        container.register(AuthServiceDescription.self) { _ in
            return MockAuthService()
        }
    }
}


