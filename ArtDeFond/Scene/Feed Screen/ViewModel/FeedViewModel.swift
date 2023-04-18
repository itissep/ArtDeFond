//
//  FeedViewModel.swift
//  ArtDeFond
//
//  Created by The GORDEEVS on 20.08.2022.
//

import Foundation
import Combine

class FeedViewModel: NSObject {
    var auctions : [CircleFeedAuctionModel] = []
    var pictures : [PictureWithAuthorModel] = []
    @Published var refreshing = false
    
    private let pictureService: PictureServiceDescription
    private let authService: AuthServiceDescription
    
    init(pictureService: PictureServiceDescription,
         authService: AuthServiceDescription) {
        self.pictureService = pictureService
        self.authService = authService
        super.init()
        fetchData()
    }
    
    // MARK: - Public methods
    
    func refresh(){
        fetchData()
    }
    
    func configurePictureDetailsViewModel(with id: String, _ completion: @escaping (PictureDetailViewModel) -> Void) {
        let pictureDetailsViewModel = PictureDetailViewModel(with: id, pictureService: pictureService, authService: authService)
        completion(pictureDetailsViewModel)
    }
    
    // MARK: - Private methods
    
    private func fetchData() {
        refreshing = true
        
        let group = DispatchGroup()
        var outputPictures = [PictureWithAuthorModel]()
        
        group.enter()
        loadPictures { pictures in
            group.leave()
            outputPictures = pictures
        }
        
        group.enter()
        var outputAuctions = [CircleFeedAuctionModel]()
        pictureService.loadPictureInformation(type: .auctions) { result in
            switch result {
            case .failure(let error):
                print(error)
                group.leave()
            case .success(let auctions):
                auctions.forEach { auction in
                    let newAuction = CircleFeedAuctionModel(id: auction.id, image: auction.image)
                    outputAuctions.append(newAuction)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.pictures = outputPictures
            self.auctions = outputAuctions
            self.refreshing = false
        }
    }
    
    private func loadPictures(completion: @escaping ([PictureWithAuthorModel]) -> Void) {
        pictureService.loadPictureInformation(type: .pictures) { [weak self] result in
            guard let self = self else {
                completion([])
                return
            }

            switch result {
            case .failure:
                completion([])
            case .success(let pictures):
                let group = DispatchGroup()
                var models: [String: PictureWithAuthorModel] = [:]
                
                for picture in pictures {
                    group.enter()
                    self.loadUser(for: picture) { user in
                        group.leave()
                        models[picture.id] = PictureWithAuthorModel(user: user, picture: picture)
                    }
                }
            
                group.notify(queue: .main) {
                    let resultModels = pictures.map { models[$0.id] }
                    completion(resultModels.compactMap { $0 })
                }
            }
        }
    }
    
    private func loadUser(for picture: Picture, completion: @escaping (User?) -> Void) {
        authService.getUserInformation(for: picture.author_id) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure( _):
                completion(nil)
            }
        }
    }
}


