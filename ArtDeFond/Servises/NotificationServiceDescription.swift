//
//  NotificationServiceDescription.swift
//  ArtDeFond
//
//  Created by Someone on 15.04.2023.
//

import Foundation

protocol NotificationServiceDescription {
    func loadNotifications(completion: @escaping (Result<[NotificationModel], Error>) -> Void)
    func newNotification(
        pictureId: String, // picture?
        type: NotificationType,
        orderId: String? ,// order?
        orderStatus: OrderStatus?, // ??
        time: Date,
        completion: @escaping (Result<NotificationModel, Error>) -> Void
    )
}
