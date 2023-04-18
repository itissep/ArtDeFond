//
//  NotificationCoordinator.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import Foundation
import UIKit
import Swinject

protocol NotificationsCoordinatorDescription: Coordinator {
    //    @discardableResult func goToOrder2Screen(animated: Bool ) -> Self
    //    @discardableResult func goToOrder3Screen(animated: Bool) -> Self
}


class NotificationsCoordinator: NotificationsCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    
    func start() {
        goToNotifications()
    }
    
    func goToNotifications() {
        let viewModel = NotificationsViewModel()
        let notificationVC = NotificationsViewController(viewModel: viewModel)
        navigationController.pushViewController(notificationVC, animated: true)
    }
}
