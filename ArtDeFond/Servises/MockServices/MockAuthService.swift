//
//  MockAuthService.swift
//  ArtDeFond
//
//  Created by Someone on 14.04.2023.
//

import Foundation

final class MockAuthService: AuthServiceDescription {
    func userID() -> String? {
        "some id"
    }
    
    func isAuthed() -> Bool {
        true
    }
    
    func signIn(withEmail email: String, withPassword password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
    
    func signUp(withEmail email: String, withPassword password: String, image: String, nickname: String, description: String, tags: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
    
    func getUserInformation(for user_id: String, completion: @escaping (Result<User, Error>) -> Void) {
        completion(.success(MockData.user))
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
}
