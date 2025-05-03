//
//  LoginRepository.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 30/04/25.
//

import Foundation

final class DefaultLoginRepository: LoginRepositoryProtocol {
    private var network: NetworkLoginProtocol
    init(network: NetworkLoginProtocol) {
        self.network = network
    }
    
    func loginApp(user: String, pass: String) async -> String {
        return await network.loginApp(user: user, password: pass)
    }
}

final class LoginRepositoryMock: LoginRepositoryProtocol {
    private var network: NetworkLoginProtocol
    init(network: NetworkLoginProtocol = NetworkLoginMock()) {
        self.network = network
    }
    
    func loginApp(user: String, pass: String) async -> String {
        return "token"
    }
}
