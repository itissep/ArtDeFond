//
//  FeedCoordinator.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import UIKit
import Swinject

protocol FeedCoordinatorDescription: Coordinator {
}

class FeedCoordinator: FeedCoordinatorDescription {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
    
    var pictureService: PictureServiceDescription?
    var authService: AuthServiceDescription?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
        pictureService = container?.resolve(PictureServiceDescription.self)
        authService = container?.resolve(AuthServiceDescription.self)
        goToFeedScreen()
    }
    
    func goToFeedScreen() {
        guard let pictureService, let authService else { return }
        let viewModel = FeedViewModel(
            pictureService: pictureService,
            authService: authService
        )
        let feedVC = FeedViewController(viewModel: viewModel)
        navigationController.pushViewController(feedVC, animated: true)
    }
}
