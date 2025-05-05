//
//  TransformationsRepositoryProtocol.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 05/05/25.
//

import Foundation

protocol TransformationsRepositoryProtocol {
    func getTransformations(heroId: UUID) async -> [TransformationsModel]
}
