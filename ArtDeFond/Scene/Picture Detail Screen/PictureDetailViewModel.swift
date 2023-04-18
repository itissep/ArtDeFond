//
//  PictureDetailViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 22.08.2022.
//

import Foundation
import Combine

class PictureDetailViewModel {

    @Published var picture: PictureWithAuthorModel?
    var refreshing = false
    
    private let authService: AuthServiceDescription
    private let pictureService: PictureServiceDescription
    private let pictureId: String
    
    required init(with pictureId: String,
                  pictureService: PictureServiceDescription,
                  authService: AuthServiceDescription
    ){
        self.pictureId = pictureId
        self.authService = authService
        self.pictureService = pictureService
        fetchData()
    }
    
    func loadPicture(completion: @escaping (PictureWithAuthorModel?) -> Void) {
        
        pictureService.getPictureWithId(with: pictureId) { [weak self] result in
            guard let self = self else {
                completion(nil)
                return
            }
            
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let picture):
                
                self.loadUser(for: picture) { user in
                    let resultModel = PictureWithAuthorModel(user: user, picture: picture)
                    completion(resultModel)
                }
            }
        }
    }
    
    func loadUser(for picture: Picture, completion: @escaping (User?) -> Void) {
        authService.getUserInformation(for: picture.author_id) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure( _):
                completion(nil)
            }
        }
    }
    
    func fetchData() {
        refreshing = true
        loadPicture {[weak self] pictureModel in
            self?.refreshing = false
            self?.picture = pictureModel
        }
    }
}
