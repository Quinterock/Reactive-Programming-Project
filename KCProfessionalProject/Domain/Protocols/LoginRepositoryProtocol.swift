//
//  LoginRepositoryProtocol.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 03/05/25.
//

import Foundation

protocol LoginRepositoryProtocol {
    func loginApp(user: String, pass: String) async -> String //devuelve el token JWT
}
