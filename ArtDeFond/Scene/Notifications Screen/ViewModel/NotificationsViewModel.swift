//
//  NotificationsViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 22.08.2022.
//

import UIKit
import Combine

class NotificationsViewModel: NSObject {
    
    var notifications : [NotificationAndPictureModel] = []
    @Published var refreshing = false
    
    private let pictureService: PictureServiceDescription
    private let notificationService: NotificationServiceDescription
    private let coordinator: NotificationsCoordinatorDescription
    
    init(pictureService: PictureServiceDescription,
         notificationService: NotificationServiceDescription,
         coordinator: NotificationsCoordinatorDescription) {
        self.pictureService = pictureService
        self.notificationService = notificationService
        self.coordinator = coordinator
        super.init()
        fetchData()
    }
    
    public func refresh() {
        fetchData()
    }
    
    public func goToOrderDetails(with id: String) {
        coordinator.goToOrderDetails(with: id)
    }
    
    public func goToPictureDetails(with id: String) {
        coordinator.goToPictureDetails(with: id)
    }
    
    private func loadNotifications(completion: @escaping ([NotificationAndPictureModel]) -> Void) {
        notificationService.loadNotifications { [weak self]
            result in
            
            guard let self = self else {
                completion([])
                return
            }
            
            switch result {
            case .failure( _):
                completion([])
            case .success(let notifications):
                let group = DispatchGroup()
                var models: [String: NotificationAndPictureModel] = [:]
                
                for notification in notifications {
                    group.enter()
                    self.loadPicture(for: notification, completion: { picture in
                        group.leave()
                        models[notification.id] = NotificationAndPictureModel(picture: picture, notification: notification)
                    })
                }
                group.notify(queue: .main) {
                    let resultModels = notifications.map { models[$0.id]
                    }
                    completion(resultModels.compactMap { $0 })
                }
            }
        }
    }
    
    private func loadPicture(for notification: NotificationModel, completion: @escaping (Picture?) -> Void) {
        pictureService.getPictureWithId(with: notification.pictureId) { result in
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let picture):
                completion(picture)
            }
        }
    }
    
    private func fetchData() {
        refreshing = true
        
        loadNotifications { notifications in
            self.refreshing = false
            self.notifications = notifications
        }
    }
}


