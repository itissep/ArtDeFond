//
//  PictureServiceDescription.swift
//  ArtDeFond
//
//  Created by Someone on 15.04.2023.
//

import Foundation

protocol PictureServiceDescription {
    
    func loadPictureInformation(type: ProductCollectionType, completion: @escaping (Result<[Picture], Error>) -> Void)
    
    func newPicture(
        id: String,
        title: String,
        image: String,
        description: String,
        year: Int,
        materials: String,
        width: Int,
        height: Int,
        price: Int,
        isAuction: Bool,
        auction: Auction?,
        tags: [String],
        completion: @escaping (Result<Picture, Error>) -> Void
    )
    
    func updatePictureInformation(for id: String, with newPicture: Picture, completion: @escaping (Result<Picture, Error>) -> Void)
    
    func deletePicture(with id: String)
    
    func getPictureWithId(with id: String, completion: @escaping (Result<Picture, Error>) -> Void)
}
