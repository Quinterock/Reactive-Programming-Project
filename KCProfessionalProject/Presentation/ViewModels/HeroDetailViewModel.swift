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
    @Published var transformations: [TransformationsModel] = []
    @Published var errorMessage: String?
    
    private let transformationsUseCase: TransformationUseCaseProtocol
    private let useCase: HeroUseCaseProtocol
    private let heroId: String // -------------
    private var cancellables = Set<AnyCancellable>()
    
    init(heroId: String,
         useCase: HeroUseCaseProtocol = HeroUseCase(),
         transformationsUseCase: TransformationUseCaseProtocol = TransformationUseCase()) {
        self.heroId = heroId
        self.useCase = useCase
        self.transformationsUseCase = transformationsUseCase
    }
    
    func loadHeroDetails() async {
        //        print("XXXX ALL HEROS: \(allHeros)")
        do {
            if let selectedHero = await useCase.getHero(by: heroId) {
                DispatchQueue.main.async {
                    self.hero = selectedHero
                }
                print("XXXX HeroDetailViewModel - Héroe seleccionado: \(selectedHero.name), ID: \(selectedHero.id)")
                // cargar las transformaxiones del heroe
                Task {
                    await loadTransformations(for: selectedHero.id)
                }
                 
                await print("YYYYYYY HeroDetailViewModel - Héroe seleccionado con su id:\(loadTransformations(for: selectedHero.id))")
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error al cargar los detalles del héroe: \(error.localizedDescription)"
            }
            print("Error fetching hero details: \(error.localizedDescription)")
        }
    }
    
    private func loadTransformations(for heroId: String) async {
        print("ZZZZ loadTransformations - Loading transformations for hero ID: \(heroId)") // Debug print
        
        do {
            let fetchedTransformations = await transformationsUseCase.getTransformations(for: heroId)
            print("HeroDetailViewModel - Transformations fetched: \(fetchedTransformations)") // Debug print
            print("HeroDetailViewModel - Transformations fetched number: \(fetchedTransformations.count)") // Debug print
            DispatchQueue.main.async {
                self.transformations = fetchedTransformations
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "HeroDetailViewModel - Error al cargar las transformaciones: \(error.localizedDescription)"
                print("HeroDetailViewModel - Error fetching transformations: \(error.localizedDescription)")
            }
        }
    }
}

