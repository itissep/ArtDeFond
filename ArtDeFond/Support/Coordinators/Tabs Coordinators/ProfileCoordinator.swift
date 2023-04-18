//
//  ProfileCoordinator.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import Foundation
import UIKit
import Swinject

protocol ProfileCoordinatorDescription: Coordinator {
    func goToProfile()
}

class ProfileCoordinator: ProfileCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        #warning("TODO: check foe auth")
        goToProfile()
    }

    func goToProfile() {
        let viewModel = ProfileViewModel()
        let provileVC: UIViewController =  ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(provileVC, animated: true)
    }
}

