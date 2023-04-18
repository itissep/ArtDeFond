//
//  ImageServiceDescription.swift
//  ArtDeFond
//
//  Created by Someone on 15.04.2023.
//

import UIKit

protocol ImageServiceDescription {
    func upload(image: UIImage, completion: @escaping (Result<String, Error>) -> Void)
    func image(with name: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}
