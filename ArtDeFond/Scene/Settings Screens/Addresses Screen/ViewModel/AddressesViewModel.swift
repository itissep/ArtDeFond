//
//  AddressesViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 21.08.2022.
//

import Foundation
import Combine

class AddressesViewModel: NSObject {
    @Published var addresses: [AddressesModel] = []
    
    private let authService: AuthServiceDescription
    private let addressService: AddressServiceDescription
    
    init(authService: AuthServiceDescription, addressService: AddressServiceDescription) {
        self.addressService = addressService
        self.authService = authService
        super.init()
        
        fetchAdresses()
    }
    
    func fetchAdresses() {
        guard let userId = authService.userID() else {
            return
        }
        
        addressService.loadUsersAddressInformation(for: userId) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let addressesInfo):
                var addresses = [AddressesModel]()
                addressesInfo.forEach { address in
                    let newAddress = AddressesModel(id: address.id, street: address.street, city: address.city, district: address.district, houseNumber: address.house_number, postalCode: address.post_index)
                    
                    addresses.append(newAddress)
                }
                self?.addresses = addresses
            }
        }
    }
}



struct AddressesModel {
    let id: String
    let street: String
    let city: String
    let district: String
    let houseNumber: Int
    let postalCode: Int
}
