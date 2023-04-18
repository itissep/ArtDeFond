//
//  NotificationsViewController.swift
//  ArtDeFond
//
//  Created by developer on 17.08.2022.
//

import UIKit
import SnapKit
import Combine

class NotificationsViewController: UIViewController {
    // UI
    private lazy var tableView = UITableView()
    // Model
    private var viewModel: NotificationsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    
    init(viewModel: NotificationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingSetup()
    }
    
    // MARK: - ViewModel Binding
    
    private func bindingSetup(){
        viewModel.$refreshing
            .sink {[weak self] isRefreshing in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - tableView Setup
    
    private func setup(){
        view.backgroundColor = .white
        
        title = "Уведомления"
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NotificationCommonTableCell.self, forCellReuseIdentifier: NotificationCommonTableCell.reusableId)
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 240
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(25)
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension NotificationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? NotificationCommonTableCell
        
        guard
            let cell = cell,
            let cellModel = cell.notificationModel
        else {
            return
        }
        
        switch cellModel.notification.type {
            
        case .yourPictureWasBought, .yourAuctionWasEnded, .youWonAuction, .youBoughtPicture:
            guard let orderId = cellModel.notification.orderId else {
                return
            }
            viewModel.goToOrderDetails(with: orderId)
        case .yourPictureWasBetOn, .yourBetWasBeaten:
            guard let pictureId = cellModel.picture?.id else { return }
            
            viewModel.goToPictureDetails(with: pictureId)
        }
    }
}

// MARK: - UITableViewDataSource

extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.notifications.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCommonTableCell.reusableId) as? NotificationCommonTableCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: NotificationAndPictureModel?
        
        cellModel = viewModel.notifications[indexPath.row]
        
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        cell.selectionStyle = .none
        return cell
    }
}
