//
//  OrderDetailsViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 24.08.2022.
//

import Foundation
import Combine

class OrderDetailViewModel: NSObject {

    @Published var order: OrderWithUsersModel?
    
    private let group = DispatchGroup()
    
    private let orderService: OrderServiceDescription
    private let authService: AuthServiceDescription
    private let pictureService: PictureServiceDescription
    private let addressService: AddressServiceDescription
    private let orderId: String
    
    init(
        with orderId: String,
        authService: AuthServiceDescription,
        orderService: OrderServiceDescription,
        pictureService: PictureServiceDescription,
        addressService: AddressServiceDescription
    ){
        self.orderId = orderId
        self.orderService = orderService
        self.authService = authService
        self.pictureService = pictureService
        self.addressService = addressService
        super.init()
        
        fetchData()
    }
    
    private func fetchData() {
        loadOrder { order in
            self.order = order
        }
    }
    
    private func loadOrder(completion: @escaping (OrderWithUsersModel?) -> Void) {
        orderService.getOrderWithId(with: orderId) { [weak self] result in
            guard let self = self else {
                completion(nil)
                return
            }
            
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let orderData):
                var order = OrderWithUsersModel(order: orderData)
            
                self.loadPicture(for: orderData) { order.picture = $0 }
                self.loadUser(with: orderData.buyer_id) { order.buyerUser = $0 }
                self.loadUser(with: orderData.seller_id) { order.sellerUser = $0 }
                self.loadAddress(for: orderData) { order.address = $0 }
                
                self.group.notify(queue: .main) {
                    self.order = order
                }
            }
        }
    }
    
    
    
    private func loadPicture(for order: Order, completion: @escaping (Picture?) -> Void) {
        group.enter()
        pictureService.getPictureWithId(with: order.picture_id) {[weak self] result in
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let picture):
                completion(picture)
            }
            self?.group.leave()
        }
    }
    
    private func loadAddress(for order: Order, completion: @escaping (Address?) -> Void) {
        group.enter()
        addressService.getAddressWithId(with: order.address_id) {[weak self]  result  in
            switch result {
            case .failure( _):
                completion(nil)
            case .success(let address):
                completion(address)
            }
            self?.group.leave()
        }
    }
    
    private func loadUser(with userId: String, completion: @escaping (User?) -> Void) {
        group.enter()
        authService.getUserInformation(for: userId) {[weak self] result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure( _):
                completion(nil)
            }
            self?.group.leave()
        }
    }
}

struct OrderWithUsersModel {
    let order: Order
    var buyerUser: User? = nil
    var sellerUser: User? = nil
    var picture: Picture? = nil
    var address: Address? = nil
}
