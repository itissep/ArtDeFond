//
//  AddressesViewController.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Combine
import UIKit
import SnapKit

class AddressesViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: AddressTableViewCell.reusableId)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var viewModel: AddressesViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    
    init(viewModel: AddressesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingSetup()
    }
    
    // MARK: - ViewModel Binding
    
    private func bindingSetup() {
        viewModel.$addresses
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - UI setup
    
    private func setup(){
        view.backgroundColor = .white
        
        title = "Адреса"
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(backTapped))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(addTapped))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalTo(view).offset(10)
        }
    }
    
    // MARK: - Selectors
    
    @objc
    func backTapped(){
        self.dismiss(animated: true)
    }
    
    @objc
    func addTapped(){
        print("add tapped")
    }
}

// MARK: - UITableViewDelegate

extension AddressesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource

extension AddressesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.addresses.count
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reusableId) as? AddressTableViewCell
        else {
            fatalError("unexpected cell")
        }
        let cellModel: AddressesModel?
        
        cellModel = viewModel.addresses[indexPath.row]
        if let cellModel = cellModel {
            cell.configure(model: cellModel)
        }
        cell.selectionStyle = .none
        return cell
    }
}
