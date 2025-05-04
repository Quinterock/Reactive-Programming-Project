//
//  NetworkLogin.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 30/04/25.
//

import Foundation

protocol NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String // Devuelve el token JWT
}

final class NetworkLogin: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        var tokenJWT: String = ""
        
        let url: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.login.rawValue)"
        let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        var segCredentials: String = ""
        if let credentials = encodeCredentials {
            segCredentials = "Basic \(credentials)"
        }
        
        var request: URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(segCredentials, forHTTPHeaderField: "Authorization")
        
        do {
            // Await para esperar a que nos responda
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    tokenJWT = String(decoding: data, as: UTF8.self) // Asignamos la respuesta al token
                }
            }
        } catch {
            tokenJWT = ""
        }
        return tokenJWT
    }
}

final class NetworkLoginMock: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        return UUID().uuidString
    }
}
