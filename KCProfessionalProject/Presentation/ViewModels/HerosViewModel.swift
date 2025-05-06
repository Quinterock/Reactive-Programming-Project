//
//  HerosViewModel.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import Foundation
import Combine

@MainActor
final class HerosViewModel: ObservableObject {
    //Lista de heroes
    @Published var heros = [HerosModel]()
    
    //Combine
    var suscriptors = Set<AnyCancellable>()
    private var useCaseHeros: HeroUseCaseProtocol
    
    init(useCase: HeroUseCaseProtocol = HeroUseCase()) {
        self.useCaseHeros = useCase
        Task{ [weak self] in
            await self?.loadHeros()
        }
    }
    
    func loadHeros() async {
        let data = await useCaseHeros.getHeros(filter: "")
        print("Héroes obtenidos: \(data.count)") // Debug log
        // Imprimir los IDs de todos los héroes obtenidos
            data.forEach { hero in
                print("Hero ID: \(hero.id)")
            }
        print()
        print()
        DispatchQueue.main.async {
            self.heros = data
            print("Héroes actualizados en @Published: \(self.heros.count)")
            data.forEach { hero in
                print("Hero ID: \(hero.id)")
            }
        }
    }
}
