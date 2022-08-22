//
//  UserSettingsViewController.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation
import UIKit

class UserSettingsViewController: UIViewController {
    
    var settings: [SettingsModel] = [
        SettingsModel(
            title: "Редактировать профиль",
            image: UIImage(systemName: "pencil")),
        SettingsModel(
            title: "Адреса доставки",
            image: UIImage(systemName: "house.fill"),
            viewController: UINavigationController(rootViewController: AddressesViewController(viewModel: AddressesViewModel()))),
        SettingsModel(
            title: "Мои покупки",
            image: UIImage(systemName: "shippingbox.fill"),
            viewController: UINavigationController(rootViewController: OrdersViewController(type: .purchases, viewModel: OrdersViewModel()))),
        SettingsModel(
            title: "Мои продажи",
            image: UIImage(systemName: "photo.artframe"),
            viewController: UINavigationController(rootViewController: OrdersViewController(type: .sales, viewModel: OrdersViewModel()))),
        SettingsModel(
            title: "Пополнить баланс",
            image: UIImage(systemName: "creditcard")),
        SettingsModel(
            title: "Удалить профиль",
            image: UIImage(systemName: "trash.fill")),
        SettingsModel(
            title: "Выйти из профиля",
            image: UIImage(systemName: "ipad.and.arrow.forward")),
    ]
    
    
    
    
    lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(SettingsTableCell.self, forCellReuseIdentifier: SettingsTableCell.reusableId)

        // FIXIT: Убрать последний сепаратор
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = Constants.Colors.pink
        tableView.separatorInset = .zero
        
        tableView.rowHeight = 50
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
    }
    
    private func tableViewSetup(){
        self.view.backgroundColor = .white
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        view.addSubview(settingsTableView)
        
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalTo(view).offset(10)
        }
    }
}


extension UserSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? SettingsTableCell
        
        let newVC = cell?.settingsModel?.viewController
        guard let newViewController = newVC else {
            return
        }
        
        newViewController.modalPresentationStyle = .fullScreen
        present(newViewController, animated: true)
    }
}


extension UserSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.reusableId) as? SettingsTableCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: SettingsModel?
        cellModel = settings[indexPath.row]
        
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        return cell
    }
}
