//
//  HerosRepository.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import Foundation

// El Repositorio es el vínculo entre el dominio y la capa de datos
final class HerosRepository: HerosRepositoryProtocol {
    private var network: NetworkHerosProtocol
    
    init(network: NetworkHerosProtocol) {
        self.network = network
    }
    
    /// Obtiene una lista de héroes, opcionalmente filtrados por nombre
    func getHeros(filter: String) async -> [HerosModel] {
        return await network.getHeros(filter: filter)
    }
    
    /// Obtiene un héroe específico por su ID
    func getHero(by id: String) async -> HerosModel? {
        // Llama a la red para obtener todos los héroes y filtra por ID
        let allHeros = await network.getHeros(filter: "")
        return allHeros.first { $0.id == id }
    }
}

// MARK: - Fake Repository
final class HerosRepositoryFake: HerosRepositoryProtocol {
    private var fakeData: [HerosModel]
    
    init(fakeData: [HerosModel] = []) {
        self.fakeData = fakeData
    }
    
    /// Obtiene una lista de héroes, opcionalmente filtrados por nombre
    func getHeros(filter: String) async -> [HerosModel] {
        // Simula filtrado localmente
        if filter.isEmpty {
            return fakeData
        } else {
            return fakeData.filter { $0.name?.localizedCaseInsensitiveContains(filter) ?? false }
        }
    }
    
    /// Obtiene un héroe específico por su ID
    func getHero(by id: String) async -> HerosModel? {
        // Filtra localmente los datos simulados para encontrar el héroe por ID
        return fakeData.first { $0.id == id }
    }
}

