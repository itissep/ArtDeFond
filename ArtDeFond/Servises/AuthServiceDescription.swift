//
//  AuthServiceDescription.swift
//  ArtDeFond
//
//  Created by Someone on 15.04.2023.
//

import Foundation

protocol AuthServiceDescription {
    
    func userID() -> String?
    
    func isAuthed() -> Bool

    func signIn(withEmail email: String, withPassword password: String, completion: @escaping (Result<Void, Error>) -> Void)
    
    func signUp(
        withEmail email: String,
        withPassword password: String,
        image: String,
        nickname: String,
        description: String,
        tags: [String],
        completion: @escaping (Result<Void, Error>) -> Void
    )
    
    func getUserInformation(for user_id: String, completion: @escaping (Result<User, Error>) -> Void)
    
//    func updateUserInformation(for user_id: String, completion: @escaping ()->())
    
    // user updater class??? for various types of updates (email, password, etc)
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void)
}
