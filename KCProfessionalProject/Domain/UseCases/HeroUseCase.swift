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

final class FakeHeroUseCase {
    func getHeros(filter: String) async -> [HerosModel] {
        // Datos simulados
        let hero1 = HerosModel(
            id: "1234",
            favorite: true,
            description: "Sobran las presentaciones cuando se habla de Goku...",
            photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
            name: "Goku"
        )

        let hero2 = HerosModel(
            id: "123",
            favorite: false,
            description: "Vegeta es todo lo contrario...",
            photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
            name: "Vegeta"
        )

        let allHeroes = [hero1, hero2]
        
        // Aplica el filtro si es necesario
        if filter.isEmpty {
            return allHeroes
        } else {
            return allHeroes.filter { $0.name?.localizedCaseInsensitiveContains(filter) ?? false }
        }
    }
}

