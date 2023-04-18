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
    func showSettings()
    func showPictureDetail(with id: String)
    func goToAddresses()
}

class ProfileCoordinator: ProfileCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
    private var authService: AuthServiceDescription?
    private var pictureService: PictureServiceDescription?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        authService = container?.resolve(AuthServiceDescription.self)
        pictureService = container?.resolve(PictureServiceDescription.self)
        
        goToProfile()
    }

    func goToProfile() {
        guard let authService, let pictureService else { return }
        let viewModel = ProfileViewModel(
            authService: authService,
            pictureService: pictureService,
            coordinator: self)
        let provileVC: UIViewController =  ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(provileVC, animated: true)
    }
    
    func showPictureDetail(with id: String) {
        guard let authService, let pictureService else { return }
        let viewModel = PictureDetailViewModel(with: id, pictureService: pictureService, authService: authService)
        let pictureVC = PictureDetailViewController(viewModel: viewModel)
        navigationController.visibleViewController?.present(pictureVC, animated: true)
    }
    
    func showSettings() {
        let settingsViewController = UserSettingsViewController()
        if let sheet = settingsViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        navigationController.visibleViewController?.present(settingsViewController, animated: true)
    }
    
    func goToAddresses() {
        //
    }
}

