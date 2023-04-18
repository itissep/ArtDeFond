//
//  OrderViewController.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//
import UIKit
import SnapKit
import Combine

class OrdersViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(OrdersTableViewCell.self, forCellReuseIdentifier: OrdersTableViewCell.reusableId)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var viewModel: OrdersViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    
    init(viewModel: OrdersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        bindingSetup()
    }
    
    // MARK: - ViewModel binding
    
    func bindingSetup(){
        viewModel.$orders
            .sink {[weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - UI setup
    
    private func tableViewSetup(){
        title = viewModel.getTitle()
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(backButtonTapped))
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view).offset(10)
        }
    }
    
    // MARK: - Selectors
    
    @objc
    func backButtonTapped(){
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? OrdersTableViewCell
        
        guard
            let cell = cell,
            let orderId = cell.orderModel?.order.id
        else {
            return
        }
        viewModel.toOrderDetails(with: orderId)
    }
}

// MARK: - UITableViewDataSource

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.orders.count
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTableViewCell.reusableId) as? OrdersTableViewCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: OrderAndPictureModel?
        cellModel = viewModel.orders[indexPath.row]
        
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        cell.selectionStyle = .none
        return cell
    }
}
