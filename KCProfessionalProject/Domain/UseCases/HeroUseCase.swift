//
//  HeroUseCase.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import Foundation

protocol HeroUseCaseProtocol {
    var repo:  HerosRepositoryProtocol { get set }
    func getHeros(filter: String) async -> [HerosModel]
    /// Obtiene un héroe específico por su ID.
        func getHero(by id: String) async -> HerosModel?
}


// MARK: - Implementation
final class HeroUseCase: HeroUseCaseProtocol {
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepository(network: NetworkHeros())) {
        self.repo = repo
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        return await repo.getHeros(filter: filter)
    }
    
    func getHero(by id: String) async -> HerosModel? {
            // Llama al repositorio para obtener todos los héroes y filtra por ID
            let allHeros = await repo.getHeros(filter: "")
            return allHeros.first(where: { $0.id == id })
        }
}

final class FakeHeroUseCase: HeroUseCaseProtocol {
    func getHero(by id: String) async -> HerosModel? {
        let allHeros = await repo.getHeros(filter: "")
        return allHeros.first(where: { $0.id == id })
    }
    
    var repo: HerosRepositoryProtocol
    
    init(repo: HerosRepositoryProtocol = HerosRepositoryFake()) {
        self.repo = repo
    }
    
    func getHeros(filter: String) async -> [HerosModel] {
        return await repo.getHeros(filter: filter)
    }
}
