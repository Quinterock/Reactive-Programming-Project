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
    func getTransformations(for heroId: UUID) async -> [TransformationsModel]
}

// MARK: - Implementation
final class TransformationUseCase: TransformationUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(networkTransformations: NetworkTransformations())) {
        self.repo = repo
    }
    
    func getTransformations(for heroId: UUID) async -> [TransformationsModel] {
        return await repo.getTransformations(heroId: heroId)
    }
}


//final class FakeTransformationUseCase: TransformationUseCaseProtocol {
//    var repo: TransformationsRepositoryProtocol
//    
//    init(repo: TransformationsRepositoryProtocol = TransformationsRepositoryFake()) {
//        self.repo = repo
//    }
//    
//    func getTransformations(for heroId: UUID) async -> [TransformationsModel] {
//        return await repo.getTransformations(heroId: heroId)
//    }
//}
