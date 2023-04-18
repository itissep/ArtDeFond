//
//  FeedViewModel.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import Foundation
import Combine

class ProfileViewModel: NSObject {
    var auctions : [CircleFeedAuctionModel] = []
    var pictures : [Picture] = []
    var user : User?

    @Published var refreshing = false
    
    private let authService: AuthServiceDescription
    private let pictureService: PictureServiceDescription
    private let coordinator: ProfileCoordinatorDescription
    
    private let group = DispatchGroup()
    
    init(
        authService: AuthServiceDescription,
        pictureService: PictureServiceDescription,
        coordinator: ProfileCoordinatorDescription
    ) {
        self.authService = authService
        self.pictureService = pictureService
        self.coordinator = coordinator
        super.init()
        fetchData()
    }
    
    func showSettings() {
        coordinator.showSettings()
    }
    
    func showPictrueDetails(with id: String) {
        coordinator.showPictureDetail(with: id)
    }
    
    private func fetchData() {
        refreshing = true
        
        guard let userId = authService.userID() else { return }
        
        loadPictures(for: userId)
        loadUser(for: userId)
        loadAuctions(for: userId)
        
        group.notify(queue: .main) {[weak self] in
            self?.refreshing = false
        }
    }
    
    private func loadPictures(for userId: String){
        group.enter()
        pictureService.loadPictureInformation(type: .authorsPictures(id: userId)) {[weak self] result in
            switch result {
            case .failure( _):
                self?.pictures = []
            case .success(let pictures):
                self?.pictures = pictures
            }
            self?.group.leave()
        }
    }
    
    private func loadAuctions(for userId: String){
        group.enter()
        pictureService.loadPictureInformation(type: .authorsAuctions(id: userId)) {[weak self] result in
            switch result {
            case .failure( _):
                self?.auctions = []
                
            case .success(let auctions):
                var outputAuctions = [CircleFeedAuctionModel]()
                auctions.forEach { auction in
                    let newAuction = CircleFeedAuctionModel(id: auction.id, image: auction.image)
                    outputAuctions.append(newAuction)
                }
                self?.auctions = outputAuctions
            }
            self?.group.leave()
        }
    }
    
    private func loadUser(for userId: String){
        group.enter()
        authService.getUserInformation(for: userId) {[weak self] result in
            switch result {
            case .failure( _):
                break
            case .success(let user):
                self?.user = user
            }
            self?.group.leave()
        }
    }
}
