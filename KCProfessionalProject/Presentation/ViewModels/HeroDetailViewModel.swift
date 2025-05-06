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
        let allHeros = await useCase.getHeros(filter: "")
        if let selectedHero = allHeros.first(where: { $0.id == heroId }) {
            DispatchQueue.main.async {
                self.hero = selectedHero
            }
            print("Héroe seleccionado: \(selectedHero.name), ID: \(selectedHero.id)")
            print("Loading transformations for hero ID: \(selectedHero.id)")
            await loadTransformations(for: selectedHero.id)
        }
    }
    
    private func loadTransformations(for heroId: String) async {
        print("Loading transformations for hero ID: \(heroId)") // Debug print
        
        do {
            let fetchedTransformations = await transformationsUseCase.getTransformations(for: heroId)
            print("Transformations fetched: \(fetchedTransformations.count)") // Debug print
            DispatchQueue.main.async {
                self.transformations = fetchedTransformations
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Error al cargar las transformaciones: \(error.localizedDescription)"
                print("Error fetching transformations: \(error.localizedDescription)")
            }
        }
    }

}





/*
 private func loadTransformations(for heroId: UUID) async {
     // Usar un ID no UUID para pruebas
     let fixedHeroId = "D13A40E5-4418-4223-9CE6-D2F9A28EBE94" // Cambiar "abcd" al ID deseado
     print("Loading transformations for hero ID: \(fixedHeroId)") // Debug print
     
     do {
         let fetchedTransformations = await transformationsUseCase.getTransformations(for: UUID(uuidString: fixedHeroId) ?? heroId) // Cambiar lógica si es necesario
         print("XXXXXXXXX")
         print()
         print("Loading transformations for hero ID: \(heroId)")
         print("Transformations fetched: \(fetchedTransformations.count)")
         print("Transformations fetched: \(fetchedTransformations.count)") // Debug print
         DispatchQueue.main.async {
             self.transformations = fetchedTransformations
         }
     } catch {
         DispatchQueue.main.async {
             self.errorMessage = "Error al cargar las transformaciones: \(error.localizedDescription)"
             print("Error fetching transformations: \(error.localizedDescription)")
         }
     }
 }
 */







//    private func loadTransformations(for heroId: UUID) async {
//            let fetchedTransformations = await transformationsUseCase.getTransformations(for: heroId)
//        print("XXXXXXXXX")
//        print()
//        print("Loading transformations for hero ID: \(heroId)")
//        print("Transformations fetched: \(fetchedTransformations.count)")
//            DispatchQueue.main.async {
//                self.transformations = fetchedTransformations
//            }
//    }




//import Foundation
//import Combine
//
//final class HeroDetailViewModel: ObservableObject {
//    @Published var hero: HerosModel?
//    @Published var transformations: [TransformationsModel] = [] // Para transformaciones
//    @Published var errorMessage: String?
//
//    private let transformationsRepository: TransformationsRepositoryProtocol
//    private let useCase: HeroUseCaseProtocol
//    private let heroId: UUID
//    private var cancellables = Set<AnyCancellable>()
//
//    init(heroId: UUID,
//         useCase: HeroUseCaseProtocol = HeroUseCase(),
//         transformationsRepository: TransformationsRepositoryProtocol = TransformationsRepository()) {
//        self.heroId = heroId
//        self.useCase = useCase
//        self.transformationsRepository = transformationsRepository
//    }
//
//    func loadHeroDetails() async {
//        // Llamada para obtener todos los héroes a través del caso de uso
//        let allHeros = await useCase.getHeros(filter: "")
//        if let selectedHero = allHeros.first(where: { $0.id == heroId }) {
//            DispatchQueue.main.async {
//                self.hero = selectedHero // Asignamos el héroe seleccionado
//            }
//            // Cargar transformaciones para el héroe seleccionado
//            await loadTransformations(for: selectedHero.id)
//        }
//    }
//
//    private func loadTransformations(for heroId: UUID) async {
//            // Obtener las transformaciones desde el repositorio
//            let fetchedTransformations = await transformationsRepository.getTransformations(heroId: heroId)
//        print("Transformations fetched: \(fetchedTransformations.count)")
//            DispatchQueue.main.async {
//                self.transformations = fetchedTransformations
//            }
//
//    }
//}


/*
 import Foundation
 import Combine
 
 final class HeroDetailViewModel: ObservableObject {
 @Published var hero: HerosModel?
 @Published var transformations: [TransformationsModel] = [] // Para transformaciones
 @Published var errorMessage: String?
 
 private let transformationsRepository: TransformationsRepositoryProtocol
 private let useCase: HeroUseCaseProtocol
 private let heroId: UUID
 private var cancellables = Set<AnyCancellable>()
 
 init(heroId: UUID,
 useCase: HeroUseCaseProtocol = HeroUseCase(),
 transformationsRepository: TransformationsRepositoryProtocol = TransformationsRepository()) {
 self.heroId = heroId
 self.useCase = useCase
 self.transformationsRepository = transformationsRepository
 }
 
 func loadHeroDetails() async {
 // Llamada para obtener todos los héroes a través del caso de uso
 let allHeros = await useCase.getHeros(filter: "")
 if let selectedHero = allHeros.first(where: { $0.id == heroId }) {
 DispatchQueue.main.async {
 self.hero = selectedHero // Asignamos el héroe seleccionado
 }
 // Cargar transformaciones para el héroe seleccionado
 await loadTransformations(for: selectedHero.id)
 }
 }
 
 private func loadTransformations(for heroId: UUID) async {
 do {
 // Obtener las transformaciones desde el repositorio
 let fetchedTransformations = await transformationsRepository.getTransformations(heroId: heroId)
 DispatchQueue.main.async {
 self.transformations = fetchedTransformations
 }
 } catch {
 DispatchQueue.main.async {
 self.errorMessage = "Error al cargar las transformaciones: \(error.localizedDescription)"
 }
 }
 }
 }
 */
