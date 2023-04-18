//
//  OrderServiceDescription.swift
//  ArtDeFond
//
//  Created by Someone on 15.04.2023.
//

import Foundation

protocol OrderServiceDescription {
    
    func getOrderWithId(with id: String, completion: @escaping (Result<Order, Error>) -> Void)
    
    func loadOrders(type: OrderType, completion: @escaping (Result<[Order], Error>) -> Void)
    
    func newOrder(
        id: String,
        picture_id: String, // picture
        time: Date,
        address_id: String, // address
        status: OrderStatus,
        seller_id: String, // user
        buyer_id: String, // user
        total_amount: Int,
        completion: @escaping (Result<Order, Error>) -> Void
    )
    
    func updateOrderStatus(
        for order_id: String,
        to newStatus: OrderStatus,
        completion: @escaping (Result<Order, Error>) -> Void
    )
}
