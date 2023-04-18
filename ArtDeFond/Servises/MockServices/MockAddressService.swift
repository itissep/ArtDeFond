//
//  MockAddressService.swift
//  ArtDeFond
//
//  Created by Someone on 14.04.2023.
//

import Foundation

final class MockAddressService: AddressServiceDescription {
    func getAddressWithId(with id: String, completion: @escaping (Result<Address, Error>) -> Void) {
        completion(.success(MockData.address))
    }
    
    func loadUsersAddressInformation(for user_id: String, completion: @escaping (Result<[Address], Error>) -> Void) {
        completion(.success([MockData.address]))
    }
    
    func newAddress(id: String, user_id: String, street: String, house_number: Int, apartment_number: Int, post_index: Int, district: String, city: String, completion: @escaping (Result<Address, Error>) -> Void) {
        completion(.success(MockData.address))
    }
    
    func updateAddressInformation(for id: String, with newAddress: Address, completion: @escaping (Result<Address, Error>) -> Void) {
        completion(.success(MockData.address))
    }
    
    func deleteAddress(with id: String) {
        print("address was deleted")
    }
}
