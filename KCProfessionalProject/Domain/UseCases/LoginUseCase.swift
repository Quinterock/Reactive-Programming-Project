//
//  LoginUseCase.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 30/04/25.
//

import Foundation
import QuinteroLibrary

protocol LoginUseCase {
    func login(user: String, password: String) async -> Bool
    func logout() async
    func validateToken() async -> Bool
}

final class DefaultLoginUseCase: LoginUseCase {
    // any es una manera para que te ayude con un protocolo, como any ouede haber cualquier objeto que contenga un protocolo
    var repo: any LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository(network: NetworkLogin())) {
        self.repo = repo
    }
    
    func login(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, pass: password)
        
        if token != "" {
            return KeyChainManager.shared.setKey(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
            
        } else {
            return KeyChainManager.shared.removeKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        }
    }
    
    func logout() async {
        let _ = KeyChainManager.shared.removeKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        return KeyChainManager.shared.getKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN) != ""
    }
}

final class FakeLoginUseCase: LoginUseCase {
    // any es una manera para que te ayude con un protocolo, como any ouede haber cualquier objeto que contenga un protocolo
    var repo: any LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = LoginRepositoryMock()) {
        self.repo = repo
    }
    
    func login(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, pass: password)
        return KeyChainManager.shared.setKey(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN, value: token)
    }
    
    func logout() async {
        let _ = KeyChainManager.shared.removeKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        return true
    }
}
