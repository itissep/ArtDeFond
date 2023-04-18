//
//  MockNotificationService.swift
//  ArtDeFond
//
//  Created by Someone on 14.04.2023.
//

import Foundation

final class MockNotificationService: NotificationServiceDescription {
    func loadNotifications(completion: @escaping (Result<[NotificationModel], Error>) -> Void) {
        completion(.success([MockData.notification]))
    }
    
    func newNotification(pictureId: String, type: NotificationType, orderId: String?, orderStatus: OrderStatus?, time: Date, completion: @escaping (Result<NotificationModel, Error>) -> Void) {
        completion(.success(MockData.notification))
    }
    
    
}
