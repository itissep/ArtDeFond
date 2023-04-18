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
    
    func showSignOutAlert()
    func showDeleteAccountAlert()
    
    func goToOrdersScreen(with type: SettingType)
    func showOrderDetails(with id: String)
}

class ProfileCoordinator: ProfileCoordinatorDescription {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var ordersListVC: UINavigationController?

    var container: Container?
    private var authService: AuthServiceDescription?
    private var pictureService: PictureServiceDescription?
    private var orderService: OrderServiceDescription?
    private var addressService: AddressServiceDescription?

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        authService = container?.resolve(AuthServiceDescription.self)
        pictureService = container?.resolve(PictureServiceDescription.self)
        orderService = container?.resolve(OrderServiceDescription.self)
        addressService = container?.resolve(AddressServiceDescription.self)
        
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
        let viewModel = SettingsViewModel(coordinator: self)
        let settingsViewController = UserSettingsViewController(viewModel: viewModel)
        if let sheet = settingsViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        navigationController.visibleViewController?.present(settingsViewController, animated: true)
    }
    
    func goToAddresses() {
        guard let addressService, let authService else { return }
        let viewModel = AddressesViewModel()
        let addressesVC = AddressesViewController(viewModel: viewModel)
        addressesVC.modalPresentationStyle = .fullScreen
        navigationController.visibleViewController?.present(addressesVC, animated: true)
    }
    
    func showSignOutAlert() {
        let alert = UIAlertController.createAlert(
            withTitle: "Хотите выйти из профиля?",
            message: "Вы всегда можете к нам вернуться!",
            buttonString: "Выйти") {[weak self] _ in
                #warning("TODO: sign out logic")
//                self?.authService.signOut { _ in
//                     // выкинуть на ленту и обновить вкладку профиля
//                    }
                }
        navigationController.visibleViewController?.present(alert, animated: true, completion: nil)
    }
    
    func showDeleteAccountAlert() {
        let alert = UIAlertController.createAlert(
            withTitle: "Хотите удалить профиль?",
            message: "Это дейстивие нельзя отменить. Вы покинете нас безвозвратно!",
            buttonString: "Удалить") {[weak self] _ in
                #warning("TODO: delete alert logic")
//                self?.authService.deleteAccount { _ in
//                    // выкинуть на ленту и обновить вкладку профиля
//                }
            }
        navigationController.visibleViewController?.present(alert, animated: true, completion: nil)
    }
    
    func goToOrdersScreen(with type: SettingType) {
        guard let orderService, let pictureService else { return }
        let orderType: OrderType = type == .purchases ? .purchases : .sales
        let viewModel = OrdersViewModel(for: orderType,
                                        orderService: orderService,
                                        pictureService: pictureService,
                                        coordinator: self)
        let ordersVC = OrdersViewController(viewModel: viewModel)
        ordersListVC = UINavigationController(rootViewController: ordersVC)
        guard let ordersListVC else { return }
        ordersListVC.modalPresentationStyle = .fullScreen
        navigationController.visibleViewController?.present(ordersListVC, animated: true)
    }
    
    func showOrderDetails(with id: String) {
        guard let ordersListVC,
                let authService, let orderService, let pictureService, let addressService else { return }
        let viewModel = OrderDetailViewModel(with: id,
                                             authService: authService,
                                             orderService: orderService,
                                             pictureService: pictureService,
                                             addressService: addressService)
        let orderDetailsVC = OrderDetailsViewController(viewModel: viewModel)
        ordersListVC.pushViewController(orderDetailsVC, animated: true)
    }
}
