//
//  HerosRepository.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import Foundation

// El Repositorio es el vinculo entre el dominio y capa de datos

final class HerosRepository: HerosRepositoryProtocol {
    private var network: NetworkHerosProtocol
    
    init(network: NetworkHerosProtocol) {
        self.network = network
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        return await network.getHeros(filter: filter)
    }
}

final class HerosRepositoryFake: HerosRepositoryProtocol {
    private var network: NetworkHerosProtocol
    
    init(network: NetworkHerosProtocol = NetworkHerosMock()) {
        self.network = network
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        return await network.getHeros(filter: filter)
    }
    
    
    
    
}
