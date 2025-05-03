//
//  LoginRepository.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 30/04/25.
//

import Foundation

protocol LoginRepositoryProtocol {
    
    
    func loginApp(user: String, pass: String) async -> String // Devuelve el token JWT

}
