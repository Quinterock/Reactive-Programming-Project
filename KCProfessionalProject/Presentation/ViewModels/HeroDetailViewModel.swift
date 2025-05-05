//
//  HeroDetailViewModel.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 04/05/25.
//

import Foundation
import Combine

final class HeroDetailViewModel: ObservableObject {
    @Published var hero: HerosModel?
    private var heroId: UUID
    private var useCase: HeroUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(heroId: UUID, useCase: HeroUseCaseProtocol = HeroUseCase()) {
        self.heroId = heroId
        self.useCase = useCase
    }
    
    func loadHeroDetails() async {
        // Llamada simulada a través del caso de uso
        let allHeros = await useCase.getHeros(filter: "")
        if let selectedHero = allHeros.first(where: { $0.id == heroId }) {
            DispatchQueue.main.async {
                self.hero = selectedHero // Asignamos el héroe seleccionado
            }
        }
    }
}
