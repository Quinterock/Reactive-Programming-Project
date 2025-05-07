//
//  TransformationsModel.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import Foundation

struct TransformationsModel: Codable {
    let id: String
    let description: String
    let photo: String
    let name: String
    let hero: HerosModel?
}


// Filter the request of Transformations by name
struct TransformationModelRequest: Codable {
    let name: String
}
