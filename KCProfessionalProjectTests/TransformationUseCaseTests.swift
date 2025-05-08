//
//  KCProfessionalProjectTests.swift
//  KCProfessionalProjectTests
//
//  Created by Luis Quintero on 30/04/25.
//

import XCTest
@testable import KCProfessionalProject

final class TransformationUseCaseTests: XCTestCase {
    var fakeTransformationUseCase: FakeTransformationUseCase!
    
    override func setUp() {
        super.setUp()
        // Inicializa el FakeTransformationUseCase antes de cada prueba
        fakeTransformationUseCase = FakeTransformationUseCase()
    }
    
    override func tearDown() {
        // Limpia la instancia del FakeTransformationUseCase después de cada prueba
        fakeTransformationUseCase = nil
        super.tearDown()
    }
    
    func testGetTransformations_withFakeData() async {
        // GIVEN: El ID del héroe Goku
        let heroId = "1234"
        
        // WHEN: Se llama al método getTransformations del FakeTrasformationUseCase
        let transformations = await fakeTransformationUseCase.getTransformations(for: heroId)
        
        // THEN: Verifica que las transformaciones devueltas sean las esperadas
        XCTAssertEqual(transformations.count, 2, "Goku debe tener 2 transformaciones en los datos simulados.")
        XCTAssertEqual(transformations[0].name, "Super Saiyan", "La primera transformación de Goku debe ser 'Super Saiyan'.")
        XCTAssertEqual(transformations[1].name, "Ultra Instinto", "La segunda transformación de Goku debe ser 'Ultra Instinto'.")
    }
    
    func testGetTransformations_withDifferentHero() async {
        // GIVEN: El ID del héroe Vegeta
        let heroId = "123"
        
        // WHEN: Se llama al método getTransformations del FakeTransformationUseCase
        let transformations = await fakeTransformationUseCase.getTransformations(for: heroId)
        
        // THEN: Verifica que las transformaciones devueltas sean las esperadas
        XCTAssertEqual(transformations.count, 1, "Vegeta debe tener 1 transformación en los datos simulados.")
        XCTAssertEqual(transformations[0].name, "Super Saiyan Blue", "La transformación de Vegeta debe ser 'Super Saiyan Blue'.")
    }
    
    func testGetTransformations_withNoMatchingHero() async {
        // GIVEN: Un ID de héroe que no existe
        let heroId = "9999"
        
        // WHEN: Se llama al método getTransformations del FakeTransformationUseCase
        let transformations = await fakeTransformationUseCase.getTransformations(for: heroId)
        
        // THEN: Verifica que no se devuelvan tranformaciones
        XCTAssertEqual(transformations.count, 0, "No debe haber transformaciones para un héroe inexistente.")
    }
}
