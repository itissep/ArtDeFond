//
//  FeedCoordinator.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import UIKit
import Swinject

protocol FeedCoordinatorDescription: Coordinator {
    func goToProduct(with id: String)
}

class FeedCoordinator: FeedCoordinatorDescription {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
    
    var pictureService: PictureServiceDescription?
    var authService: AuthServiceDescription?
    // add services
    
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
            authService: authService,
            coordinator: self
        )
        let feedVC = FeedViewController(viewModel: viewModel)
        navigationController.pushViewController(feedVC, animated: true)
    }
    
    func goToProduct(with id: String) {
        let viewModel = PictureDetailViewModel(with: id)
        let productVC = PictureDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(productVC, animated: true)
    }
}
