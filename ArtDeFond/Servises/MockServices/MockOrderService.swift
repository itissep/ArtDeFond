//
//  MockOrderService.swift
//  ArtDeFond
//
//  Created by Someone on 14.04.2023.
//

import Foundation

final class MockOrderService: OrderServiceDescription {
    func getOrderWithId(with id: String, completion: @escaping (Result<Order, Error>) -> Void) {
        completion(.success(MockData.order))
    }
    
    func loadOrders(type: OrderType, completion: @escaping (Result<[Order], Error>) -> Void) {
        completion(.success([MockData.order]))
    }
    
    func newOrder(id: String, picture_id: String, time: Date, address_id: String, status: OrderStatus, seller_id: String, buyer_id: String, total_amount: Int, completion: @escaping (Result<Order, Error>) -> Void) {
        completion(.success(MockData.order))
    }
    
    func updateOrderStatus(for order_id: String, to newStatus: OrderStatus, completion: @escaping (Result<Order, Error>) -> Void) {
        completion(.success(MockData.order))
    }
}
