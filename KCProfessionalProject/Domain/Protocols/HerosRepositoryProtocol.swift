//
//  HerosRepositoryProtocol.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import Foundation

protocol HerosRepositoryProtocol {
    func getHeros(filter: String) async -> [HerosModel]
    
    // Obtiene un héroe específico por su ID.
    func getHero(by id: String) async -> HerosModel?
}

