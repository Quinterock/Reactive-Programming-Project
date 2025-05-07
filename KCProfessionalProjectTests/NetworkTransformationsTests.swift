//
//  KCProfessionalProjectTests.swift
//  KCProfessionalProjectTests
//
//  Created by Luis Quintero on 30/04/25.
//

import XCTest
@testable import KCProfessionalProject

final class NetworkTransformationsTests: XCTestCase {
    var networkTransformations: NetworkTransformations!
    var networkTransformationsMock: NetworkTransformationsMock!
    
    override func setUp() {
        super.setUp()
        // Inicializa las impelementaciones reales y simuladas antes de cada prueba
        networkTransformations = NetworkTransformations()
        networkTransformationsMock = NetworkTransformationsMock()
    }
    
    override func tearDown() {
        // Limpia las instancias después de cada prueba
        networkTransformations = nil
        networkTransformationsMock = nil
        super.tearDown()
    }
    
    // MARK: - Tests para la implementación real (NetworkTransformations)
    func testGetHeros_realImplementation() async {
        // Dado un filtro de búsqueda vacío
        let filter = ""
        
        // Cuando se llama al método getHeros
        let heroes = await networkTransformations.getHeros(filter: filter)
        
        // Entonces verifica que los héroes devueltos no sean nulos
        XCTAssertNotNil(heroes, "La lista de héroes no debería ser nula.")
    }
    
    func testGetTransformations_realImplementation() async {
        // Dado un ID de héroe válido
        let heroId = "1234"
        
        // Cuando se llama al método getTransformations
        let transformations = await networkTransformations.getTransformations(heroId: heroId)
        
        // Entonces verifica que las transformaciones devueltas no sean nulas
        XCTAssertNotNil(transformations, "La lista de transformaciones no debería ser nula.")
    }
    
    // MARK: - Tests para la implementación simulada (NetworkTransformationsMock)
    func testGetHeros_mockImplementation() async {
        // GIVEN
        // Dado un filtro de búsqueda vacío
        let filter = ""
        
        // WHEN
        // Cuando se llama al método getHeros en el mock
        let heroes = await networkTransformationsMock.getHeros(filter: filter)
        
        // THEN
        // Entonces verifica que los héroes simulados sean correctos
        XCTAssertEqual(heroes.count, 2, "Debe haber 2 héroes simulados.")
        XCTAssertEqual(heroes[0].name, "Goku", "El primer héroe debe ser Goku.")
        XCTAssertEqual(heroes[1].name, "Vegeta", "El segundo héroe debe ser Vegeta.")
    }
    
    func testGetTransformations_mockImplementation_goku() async {
        // GIVEN
        // Dado un ID de héroe válido (Goku)
        let heroId = "1234"
        
        //WHEN
        // Cuando se llama al método getTransformations en el mock
        let transformations = await networkTransformationsMock.getTransformations(heroId: heroId)
        
        // THEN
        // Entonces verifica que las transformaciones sean correctas
        XCTAssertEqual(transformations.count, 2, "Goku debe tener 2 transformaciones simuladas.")
        XCTAssertEqual(transformations[0].name, "Super Saiyan", "La primera transformación debe ser Super Saiyan.")
        XCTAssertEqual(transformations[1].name, "Ultra Instinto", "La segunda transformación debe ser Ultra Instinto.")
    }
    
    func testGetTransformations_mockImplementation_vegeta() async {
        // GIVEN
        // Dado un ID de héroe válido (Vegeta)
        let heroId = "123"
        
        //WHEN
        // Cuando se llama al método getTransformations en el mock
        let transformations = await networkTransformationsMock.getTransformations(heroId: heroId)
        
        // THEN
        // Entonces verifica que las transformaciones sean correctas
        XCTAssertEqual(transformations.count, 1, "Vegeta debe tener 1 transformación simulada.")
        XCTAssertEqual(transformations[0].name, "Super Saiyan Blue", "La transformación debe ser Super Saiyan Blue.")
    }
}
