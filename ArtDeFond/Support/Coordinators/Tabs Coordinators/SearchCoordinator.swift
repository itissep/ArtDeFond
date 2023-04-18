//
//  SearchCoordinator.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import UIKit
import Swinject

protocol SearchCoordinatorDescription: Coordinator {
//    func goToCollection(type: CollectionType)
//    func goToProduct(id: String)
    
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}

class SearchCoordinator: SearchCoordinatorDescription {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
    
    // add services
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(){
        goToSearch()
    }
    
    func goToSearch() {
        let searchVC = SearchViewController()
        navigationController.pushViewController(searchVC, animated: true)
    }
}

