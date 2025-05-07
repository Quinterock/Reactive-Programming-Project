//
//  KCProfessionalProjectTests.swift
//  KCProfessionalProjectTests
//
//  Created by Luis Quintero on 30/04/25.
//

import XCTest
@testable import KCProfessionalProject

final class NetworkLoginTests: XCTestCase {
    var networkLoginMock: NetworkLoginMock!
    
    override func setUp() {
        super.setUp()
        // Inicializa las instancias antes de cada prueba
        networkLoginMock = NetworkLoginMock()
    }
    
    override func tearDown() {
        // Limpia las instancias después de cada prueba
        networkLoginMock = nil
        super.tearDown()
    }
    
    // MARK: - Tests para la implementación simulada (NetworkLoginMock)
    func testLoginApp_mockImplementation() async {
        // GIVEN: Credenciales arbitrarias
        let user = "testUser"
        let password = "testPassword"
        
        // WHEN: Se llama al método loginApp en el mock
        let token = await networkLoginMock.loginApp(user: user, password: password)
        
        // THEN: Verifica que el token devuelto no esté vacío
        XCTAssertFalse(token.isEmpty, "El token generado por el mock no debería estar vacío.")
        XCTAssertEqual(token.count, 36, "El token generado por el mock debería tener 36 caracteres (UUID).")
    }
}
