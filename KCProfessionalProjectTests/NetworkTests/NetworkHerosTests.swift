//
//  KCProfessionalProjectTests.swift
//  KCProfessionalProjectTests
//
//  Created by Luis Quintero on 30/04/25.
//

import XCTest
@testable import KCProfessionalProject

final class NetworkHerosTests: XCTestCase {
    var networkHerosMock: NetworkHerosMock!
    
    override func setUp() {
        super.setUp()
        // Inicializa el mock antes de cada prueba
        networkHerosMock = NetworkHerosMock()
    }
    
    override func tearDown() {
        // Limpia el mock después de cada prueba
        networkHerosMock = nil
        super.tearDown()
    }
    
    // MARK: - Tests utilizando NetworkHerosMock
    
    func testGetHeros_mockImplementation() async {
        // GIVEN: Un filtro vacío
        let filter = ""
        
        // WHEN: Se llama al método getHeros en el mock
        let heroes = await networkHerosMock.getHeros(filter: filter)
        
        // THEN: Verifica que los héroes simulados sean correctos
        XCTAssertEqual(heroes.count, 2, "Debe haber 2 héroes simulados.")
        XCTAssertEqual(heroes[0].name, "Goku", "El primer héroe debe ser Goku.")
        XCTAssertEqual(heroes[1].name, "Vegeta", "El segundo héroe debe ser Vegeta.")
    }
    
    func testGetHerosHardcoded() {
        // GIVEN: Datos simulados hardcoded
        // WHEN: Se llama a la función getHerosHardcoded
        let heroes = getHerosHardcoded()
        
        // THEN: Verifica que los héroes hardcoded sean correctos
        XCTAssertEqual(heroes.count, 2, "Debe haber 2 héroes hardcoded.")
        XCTAssertEqual(heroes[0].name, "Goku", "El primer héroe debe ser Goku.")
        XCTAssertEqual(heroes[1].name, "Vegeta", "El segundo héroe debe ser Vegeta.")
    }
}
