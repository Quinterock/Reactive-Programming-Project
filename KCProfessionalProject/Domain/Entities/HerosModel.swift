//
//  HerosModel.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import Foundation

struct HerosModel: Codable {
    let id: String
    let favorite: Bool
    let description: String
    let photo: String
    let name: String
}


// Filter the request of Heros by name
struct HeroModelRequest: Codable {
    let name: String
}
