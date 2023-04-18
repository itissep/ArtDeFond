//
//  MockPictureService.swift
//  ArtDeFond
//
//  Created by Someone on 14.04.2023.
//

import Foundation

final class MockPictureService: PictureServiceDescription {
    func loadPictureInformation(type: ProductCollectionType, completion: @escaping (Result<[Picture], Error>) -> Void) {
        completion(.success([MockData.picture]))
    }
    
    func newPicture(id: String, title: String, image: String, description: String, year: Int, materials: String, width: Int, height: Int, price: Int, isAuction: Bool, auction: Auction?, tags: [String], completion: @escaping (Result<Picture, Error>) -> Void) {
        completion(.success(MockData.picture))
    }
    
    func updatePictureInformation(for id: String, with newPicture: Picture, completion: @escaping (Result<Picture, Error>) -> Void) {
        completion(.success(MockData.picture))
    }
    
    func deletePicture(with id: String) {
        print("picture ws deleted")
    }
    
    func getPictureWithId(with id: String, completion: @escaping (Result<Picture, Error>) -> Void) {
        completion(.success(MockData.picture))
    }
}
