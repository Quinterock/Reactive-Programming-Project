//
//  TransformationsRepository.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 05/05/25.
//

import Foundation

final class TransformationsRepository: TransformationsRepositoryProtocol {
    private let networkTransformations: NetworkTransformationsProtocol

    init(networkTransformations: NetworkTransformationsProtocol = NetworkTransformations()) {
        self.networkTransformations = networkTransformations
    }

    func getTransformations(heroId: String) async -> [TransformationsModel] {
        return await networkTransformations.getTransformations(heroId: heroId)
    }
}

// MARK: - TransfromationRepositoryFake
final class TransformationsRepositoryFake: TransformationsRepositoryProtocol {
    private let fakeData: [TransformationsModel]

    init(fakeData: [TransformationsModel] = []) {
        self.fakeData = fakeData
    }

    func getTransformations(heroId: String) async -> [TransformationsModel] {
        // Filtra las transformaciones por heroId en los datos falsos
        return fakeData.filter { $0.hero?.id == heroId }
    }
}
