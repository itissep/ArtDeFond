//
//  UserSettingsViewController.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation
import UIKit
import Combine

class UserSettingsViewController: UIViewController {
    private lazy var tableView: UITableView = {
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
    
    private let viewModel: SettingsViewModel
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Life Cycle
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingSetup()
        tableViewSetup()
    }
    
    // MARK: - ViewModel Binding
    
    private func bindingSetup() {
        viewModel.$settingsModels
            .sink {[weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - UI setup
    
    private func tableViewSetup(){
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalTo(view).offset(10)
        }
    }
}

// MARK: - UITableViewDelegate

extension UserSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellWasSelected(at: indexPath)
    }
}

// MARK: - UITableViewDataSource

extension UserSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.settingsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.reusableId) as? SettingsTableCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: SettingsModel?
        cellModel = viewModel.settingsModels[indexPath.row]
        
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        return cell
    }
}
