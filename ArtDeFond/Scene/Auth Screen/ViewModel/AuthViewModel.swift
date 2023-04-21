//
//  AuthViewModel.swift
//  ArtDeFond
//
//  Created by Someone on 18.04.2023.
//

import Foundation
import Combine

final class AuthViewModel: NSObject {
    @Published var isError = false
    
    private let authService: AuthServiceDescription
    private let coordinator: AuthCoordinatorDescription
    
    init(authService: AuthServiceDescription, coordinator: AuthCoordinatorDescription) {
        self.authService = authService
        self.coordinator = coordinator
    }
    
    func signIn(withEmail email: String, withPassword password: String) {
        authService.signIn(withEmail: email, withPassword: password) {[weak self] result in
            switch result {
            case .failure(_):
                self?.isError = true
            case .success(_):
                self?.didSignIn()
            }
        }
    }
    
    func goToSignUp() {
        coordinator.goToSignUp()
    }
    
    private func didSignIn() {
        coordinator.goToHomeScreen()
    }
}
