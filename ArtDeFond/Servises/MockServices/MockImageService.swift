//
//  MockImageService.swift
//  ArtDeFond
//
//  Created by Someone on 15.04.2023.
//

import UIKit

final class MockImageService: ImageServiceDescription {
    func upload(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("some imageUrl"))
    }
    
    func image(with name: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        completion(.success(UIImage(systemName: "phone") ?? UIImage()))
    }
}
