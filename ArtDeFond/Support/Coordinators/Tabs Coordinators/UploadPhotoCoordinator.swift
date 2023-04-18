//
//  UploadPhotoCoordinator.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import Foundation

import UIKit
import Swinject

protocol UploadPhotoCoordinatorDescription: Coordinator {
//    func goToCollection(type: CollectionType)
//    func goToProduct(id: String)
    
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}

class UploadPhotoCoordinator: UploadPhotoCoordinatorDescription {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
    
    // add services
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
#warning("TODO: add check for auth")
        goToUploadPhotoScreen()
    }
    
    func goToUploadPhotoScreen() {
        let viewModel = UploadPhotoViewModel()
        let uploadPhotoVC =  UploadPhotoViewController(viewModel: viewModel)
        navigationController.pushViewController(uploadPhotoVC, animated: true)
    }
}
