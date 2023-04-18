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
//        container.register(PictureServiceDescription.self) { _ in
////            return UserDefaultsService()
//        }
    }

    private func registerMockDependencies() {
        //        container.register(UserDefaultsService.self) { _ in
        //            return UserDefaultsService()
        //        }
        
    }
}


