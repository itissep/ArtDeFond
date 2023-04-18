//
//  Coordinator.swift
//  ArtDeFond
//
//  Created by developer on 11.08.2022.
//

import Foundation
import UIKit

import UIKit
import Swinject

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    var container: Container? { get set }

    func start()
}

extension Coordinator {
    func childDidFinish(_ coordinator: Coordinator) {
        for (index, child) in children.enumerated() where child === coordinator {
                children.remove(at: index)
                break
        }
    }
}
