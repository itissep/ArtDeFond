//
//  AuthCoordinator.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import UIKit
import Swinject

protocol AuthCoordinatorDescription: Coordinator {
    func goToSignIn()
    func goToSignUp()
    func goToHomeScreen()
}

class AuthCoordinator: AuthCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
    var authService: AuthServiceDescription?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        authService = container?.resolve(AuthServiceDescription.self)
        
        goToSignIn()
    }

    func goToSignIn() {
        guard let authService else { return }
        let viewModel = AuthViewModel(authService: authService, coordinator: self)
        let vc = AuthViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }

    func goToSignUp() {
        let vc = SignUpViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToHomeScreen() {
        
    }
}
