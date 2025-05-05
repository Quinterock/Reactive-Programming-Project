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

    func getTransformations(heroId: UUID) async -> [TransformationsModel] {
        return await networkTransformations.getTransformations(heroId: heroId)
    }
}
