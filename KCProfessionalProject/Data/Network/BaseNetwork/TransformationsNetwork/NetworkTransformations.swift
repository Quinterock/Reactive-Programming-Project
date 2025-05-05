//
//  NetworkTransformations.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 05/05/25.
//

import Foundation
import QuinteroLibrary

protocol NetworkTransformationsProtocol {
    func getHeros(filter: String) async -> [HerosModel]
    func getTransformations(heroId: UUID) async -> [TransformationsModel]
}

final class NetworkTransformations: NetworkTransformationsProtocol {
    func getHeros(filter: String) async -> [HerosModel] {
        var modelReturn = [HerosModel]()
        
        let url: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.heros.rawValue)"
        var request: URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(HeroModelRequest(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
    
        // Token JWT (extraer de aquí o usar un interceptor genérico)
        let jwtToken = KeyChainManager.shared.getKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        if let tokenJWT = jwtToken {
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        }
        
        // Realizar la llamada al servidor
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Asegurarnos de que la respuesta sea HTTPURLResponse y que sea exitosa
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    modelReturn = try JSONDecoder().decode([HerosModel].self, from: data)
                }
            }
        } catch {
            // Manejo de errores (podrías agregar logs o lanzar un error genérico)
            print("Error al obtener héroes: \(error.localizedDescription)")
        }
        
        return modelReturn
    }
    
    func getTransformations(heroId: UUID) async -> [TransformationsModel] {
        var modelReturn = [TransformationsModel]()
        
        let url: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.transformations.rawValue)"
        var request: URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(["heroId": heroId.uuidString]) // Cuerpo de la solicitud con el ID del héroe
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
    
        // Token JWT (extraer de aquí o usar un interceptor genérico)
        let jwtToken = KeyChainManager.shared.getKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        if let tokenJWT = jwtToken {
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
        }
        
        
        
        // Realizar la llamada al servidor
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Asegurarnos de que la respuesta sea HTTPURLResponse y que sea exitosa
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    modelReturn = try JSONDecoder().decode([TransformationsModel].self, from: data)
                }
            }else {
                print("API Response Code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                print("API Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
            }
        } catch {
            // Manejo de errores (puedes agregar logs o lanzar un error genérico)
            print("Error al obtener transformaciones: \(error.localizedDescription)")
        }
        
        return modelReturn
    }
    
}







//import Foundation
//import QuinteroLibrary
//
//protocol NetworkTransformationsProtocol {
//    func
//}
//
//
//final class NetworkTransformations: NetworkTransformationsProtocol {
//    func getHeros(filter: String) async -> [HerosModel] {
//        var modelReturn = [HerosModel]()
//        
//        let url : String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.transformations.rawValue)"
//        var request : URLRequest = URLRequest(url: URL(string: url)!)
//        request.httpMethod = HTTPMethods.post
//        request.httpBody = try? JSONEncoder().encode(HeroModelRequest(name: filter))
//        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
//    
//        //Token JWT (habría que extraer de aqui) a algo generico o interceptor
//        let JwtToken =  KeyChainManager.shared.getKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
//        if let tokenJWT = JwtToken{
//            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization") //Token
//        }
//        
//        //Call to server
//        
//        do{
//            
//            let (data, response) = try await URLSession.shared.data(for: request)
//            
//            // Asegurarnos que la respuesta sea HTTPURLResponse y que sea correcta
//            if let resp = response  as? HTTPURLResponse {
//                if resp.statusCode == HTTPResponseCodes.SUCCESS {
//                    modelReturn = try! JSONDecoder().decode([HerosModel].self, from: data)
//                }
//            }
//            
//        }catch{
//            
//        }
//        
//        return modelReturn
//    }
//}


