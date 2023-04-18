//
//  AddressServiceDescription.swift
//  ArtDeFond
//
//  Created by Someone on 15.04.2023.
//

import Foundation

protocol AddressServiceDescription {
    func getAddressWithId(with id: String, completion: @escaping (Result<Address, Error>) -> Void)
    
    func loadUsersAddressInformation(
        for user_id: String,
        completion: @escaping (Result<[Address], Error>) -> Void)
    
    func newAddress(
        id: String,
        user_id: String,
        street: String,
        house_number: Int,
        apartment_number: Int,
        post_index: Int,
        district: String,
        city: String,
        completion: @escaping (Result<Address, Error>) -> Void
    )
    
    func updateAddressInformation(
        for id: String,
        with newAddress: Address,
        completion: @escaping (Result<Address, Error>) -> Void)
    
    func deleteAddress(with id: String)
}
