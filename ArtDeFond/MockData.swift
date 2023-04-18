//
//  MockData.swift
//  ArtDeFond
//
//  Created by Someone on 14.04.2023.
//

import Foundation

struct MockData {
    static let picture = Picture(id: "", title: "title", image: "image", description: "description", year: 2001, materials: "Some cool materials", width: 12, height: 23, author_id: "authorId", price: 1234, isAuction: false, tags: [], time: Date.now)
    
    static let order = Order(id: "id", picture_id: "some pic id", time: .now, address_id: "", status: .purchased, seller_id: "", buyer_id: "", total_amount: 1234)
    
    static let user = User(id: "id", email: "email", nickname: "nickname", description: "fantastic person", tags: [], avatar_image: "avatar image", account_balance: 123)
    
    static let notification = NotificationModel(id: "id", userId: "userId", pictureId: "pictureId", type: .yourBetWasBeaten, orderId: "", orderStatus: nil, time: .now)
    
    static let address = Address(id: "id", user_id: "userId", street: "Street", house_number: 123, apartment_number: 123, post_index: 123, district: "District", city: "City")
}
