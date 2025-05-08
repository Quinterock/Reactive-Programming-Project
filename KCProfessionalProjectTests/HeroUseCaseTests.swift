//
//  KCProfessionalProjectTests.swift
//  KCProfessionalProjectTests
//
//  Created by Luis Quintero on 30/04/25.
//

import XCTest
@testable import KCProfessionalProject

final class HeroUseCaseTests: XCTestCase {
    var fakeHeroUseCase: FakeHeroUseCase!
    
    override func setUp() {
        super.setUp()
        // Inicializa el FakeHeroUseCase antes de cada prueba
        fakeHeroUseCase = FakeHeroUseCase()
    }
    
    override func tearDown() {
        // Limpia la instancia del FakeHeroUseCase después de cada prueba
        fakeHeroUseCase = nil
        super.tearDown()
    }
    
    func testGetHeros_withFakeData() async {
        // GIVEN: Un filtro vacío para obtener todos los héroes
        let filter = ""
        
        // WHEN: Se llama al método getHeros del FakeHeroUseCase
        let heroes = await fakeHeroUseCase.getHeros(filter: filter)
        
        // THEN: Verifica que los héroes devueltos sean los esperados
        XCTAssertEqual(heroes.count, 2, "Debe haber 2 héroes simulados en el repositorio fake.")
        XCTAssertEqual(heroes[0].name, "Goku", "El primer héroe debe ser Goku.")
        XCTAssertEqual(heroes[1].name, "Vegeta", "El segundo héroe debe ser Vegeta.")
    }
    
    func testGetHeros_withFilter() async {
        // GIVEN: Un filtro que coincida con un héroe en los datos simulados
        let filter = "Goku"
        
        // WHEN: Se llama al método getHeros del FakeHeroUseCase
        let heroes = await fakeHeroUseCase.getHeros(filter: filter)
        
        // THEN: Verifica que solo se devuelvan los héroes que coinciden con el filtro
        XCTAssertEqual(heroes.count, 1, "Debe haber 1 héroe que coincida con el filtro.")
        print("Héroes: \(heroes)")
        XCTAssertEqual(heroes[0].name, "Goku", "El héroe devuelto debe ser Goku.")
    }
}
