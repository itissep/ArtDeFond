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
    func goToOrderDetails(with id: String)
    func goToPictureDetails(with id: String)
}


class NotificationsCoordinator: NotificationsCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    var container: Container?
    
    private var pictureService: PictureServiceDescription?
    private var orderService: OrderServiceDescription?
    private var notificationService: NotificationServiceDescription?
    private var authService: AuthServiceDescription?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    
    func start() {
        pictureService = container?.resolve(PictureServiceDescription.self)
        orderService = container?.resolve(OrderServiceDescription.self)
        authService = container?.resolve(AuthServiceDescription.self)
        notificationService = container?.resolve(NotificationServiceDescription.self)
        goToNotifications()
    }
    
    private func goToNotifications() {
        guard let pictureService, let notificationService else { return }
        let viewModel = NotificationsViewModel(
            pictureService: pictureService,
            notificationService: notificationService,
            coordinator: self)
        let notificationVC = NotificationsViewController(viewModel: viewModel)
        navigationController.pushViewController(notificationVC, animated: true)
    }
    
    func goToOrderDetails(with id: String) {
        let viewModel = OrderDetailViewModel(with: id)
        let orderDetailsVC = OrderDetailsViewController(viewModel: viewModel)
        navigationController.visibleViewController?.present(orderDetailsVC, animated: true)
    }
    
    func goToPictureDetails(with id: String) {
        guard let pictureService, let authService else { return }
        let viewModel = PictureDetailViewModel(with: id, pictureService: pictureService, authService: authService)
        let pictureVC = PictureDetailViewController(viewModel: viewModel)
        navigationController.visibleViewController?.present(pictureVC, animated: true)
    }
}
