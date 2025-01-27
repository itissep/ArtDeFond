//
//  TagsModel.swift
//  ArtDeFond
//
//  Created by Ivan Vislov on 23.08.2022.
//

import Foundation
import UIKit

class CollectionModel {
    var title: String
    var color: UIColor
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }
}

let modelArray: [CollectionModel] = [
    CollectionModel(title: "Живопись", color: Constants.Colors.pink),
    CollectionModel(title: "Гравюра", color: Constants.Colors.pink),
    CollectionModel(title: "Абстракция", color: Constants.Colors.pink),
    CollectionModel(title: "Портрет", color: Constants.Colors.pink),
    CollectionModel(title: "Пейзаж", color: Constants.Colors.pink),
    CollectionModel(title: "Рисунок", color: Constants.Colors.pink),
    CollectionModel(title: "Авангард", color: Constants.Colors.pink),
    CollectionModel(title: "Натюрморт", color: Constants.Colors.pink),
]

class CollectionModelSearch {
    var title: String
    var imageView: UIImage
    
    init(title: String, imageView: UIImage) {
        self.title = title
        self.imageView = imageView
    }}

let modelArraySearch: [CollectionModelSearch] = [
    CollectionModelSearch(title: "Живопись", imageView: UIImage(named: "1")!),
    CollectionModelSearch(title: "Гравюра", imageView: UIImage(named: "2")!),
    CollectionModelSearch(title: "Абстракция", imageView: UIImage(named: "3")!),
    CollectionModelSearch(title: "Портрет", imageView: UIImage(named: "4")!),
    CollectionModelSearch(title: "Пейзаж", imageView: UIImage(named: "5")!),
    CollectionModelSearch(title: "Рисунок", imageView: UIImage(named: "6")!),
    CollectionModelSearch(title: "Авангард", imageView: UIImage(named: "7")!),
    CollectionModelSearch(title: "Натюрморт", imageView: UIImage(named: "8")!),
]
