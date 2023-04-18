//
//  FeedViewController.swift
//  ArtDeFond
//
//  Created by developer on 17.08.2022.
//

import UIKit
import SnapKit
import Combine

class FeedViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    // UI
    private lazy var tableView = UITableView()
    private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var refreshControll = UIRefreshControl()
    
    // Model
    private var viewModel: FeedViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    
    init(viewModel: FeedViewModel) {
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(64)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - ViewModel Binding
    
    func bindingSetup(){
        viewModel.$refreshing
            .sink {[weak self] isLoading in
                if !isLoading {
                    self?.updateDataSource()
                }
            }
            .store(in: &subscriptions)
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.collectionView.reloadData()
            self.refreshControll.endRefreshing()
        }
    }
    
    // MARK: - UI Setup
    
    private func setup(){
        title = "Лента"
        navigationController?.navigationBar.titleTextAttributes = Constants.Unspecified.titleAttributes
        view.backgroundColor = .white
        
        tableViewSetup()
        collectionViewSetup()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func tableViewSetup() {
        tableView.register(PictureFeedTableCell.self, forCellReuseIdentifier: PictureFeedTableCell.reusableId)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 240
        
        refreshControll.tintColor = Constants.Colors.darkRed
        refreshControll.addTarget(self, action: #selector(self.refreshing), for: .valueChanged)

        tableView.addSubview(refreshControll)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 64, height: 64)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(AuctionCollectionViewCell.self, forCellWithReuseIdentifier: AuctionCollectionViewCell.identifier)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
    }
    
    // MARK: - Selectors
    
    @objc
    func refreshing(){
        viewModel.refresh()
    }
}

//MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? AuctionCollectionViewCell
        
        guard
            let cell = cell,
            let auctionId = cell.auctionModel?.id
        else { return }
        viewModel.goToPicture(with: auctionId)
    }
}

//MARK: - UICollectionViewDataSource
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.auctions.count)
        return viewModel.auctions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AuctionCollectionViewCell.identifier, for: indexPath) as!
        AuctionCollectionViewCell
        cell.configure(with: viewModel.auctions[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? PictureFeedTableCell
        guard
            let cell = cell,
            let pictureId = cell.pictureModel?.picture.id
        else {
            return
        }
        viewModel.goToPicture(with: pictureId)
    }
}


//MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pictures.count
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PictureFeedTableCell.reusableId) as? PictureFeedTableCell
        else {
            fatalError("unexpected cell")
        }
        
        if !self.refreshControll.isRefreshing {
            let cellModel: PictureWithAuthorModel?
            
            cellModel = viewModel.pictures[indexPath.row]
            
            if let cellModel = cellModel {
                cell.configure(model: cellModel)
                
            }
            cell.selectionStyle = .none 
        }
            return cell
        }
    }
