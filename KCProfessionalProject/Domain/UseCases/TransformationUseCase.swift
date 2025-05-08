//
//  TransformationUseCase.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 05/05/25.
//

import Foundation

// MARK: - Protocol
protocol TransformationUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol { get set }
    func getTransformations(for heroId: String) async -> [TransformationsModel]
}

// MARK: - Implementation
final class TransformationUseCase: TransformationUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(networkTransformations: NetworkTransformations())) {
        self.repo = repo
    }
    
    func getTransformations(for heroId: String) async -> [TransformationsModel] {
        return await repo.getTransformations(heroId: heroId)
    }
}


final class FakeTransformationUseCase: TransformationUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol {
        get { fatalError("FakeTransformationUseCase does not use a real repository") }
        set {}
    }

    func getTransformations(for heroId: String) async -> [TransformationsModel] {
        // Heroe simulado: Goku
        let heroGoku = HerosModel(
            id: "1234",
            favorite: true,
            description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra...",
            photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
            name: "Goku"
        )

        // Heroe simulado: Vegeta
        let heroVegeta = HerosModel(
            id: "123",
            favorite: true,
            description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable...",
            photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
            name: "Vegeta"
        )

        // Datos simulados de transformaciones
        let transformations = [
            TransformationsModel(
                id: "1",
                description: "Goku se transforma en Super Saiyan cuando su ira alcanza el límite...",
                photo: "",
                name: "Super Saiyan",
                hero: heroGoku
            ),
            TransformationsModel(
                id: "2",
                description: "Goku alcanza el Ultra Instinto, una técnica avanzada que solo los ángeles dominan...",
                photo: "",
                name: "Ultra Instinto",
                hero: heroGoku
            ),
            TransformationsModel(
                id: "3",
                description: "Vegeta logra alcanzar el poder de Super Saiyan Blue después de un entrenamiento intenso...",
                photo: "",
                name: "Super Saiyan Blue",
                hero: heroVegeta
            )
        ]

        // Filtra las transformaciones según el heroId proporcionado
        return transformations.filter { $0.hero?.id == heroId }
    }
}
