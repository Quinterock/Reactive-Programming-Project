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
    func getTransformations(heroId: String) async -> [TransformationsModel]
}

final class NetworkTransformations: NetworkTransformationsProtocol {
    func getHeros(filter: String) async -> [HerosModel] {
        var modelReturn = [HerosModel]()
        
        let url: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.heros.rawValue)"
        var request: URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(HeroModelRequest(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
    
        print()
        print("urlhero:\(url) requestHero\(request), filter: \(filter), name: \(modelReturn)")
        print()
        
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
                    print()
                    print("urlhero:\(url) requestHero\(request), filter: \(filter), name: \(modelReturn)")
                    print()
                }
            }
        } catch {
            // Manejo de errores (podrías agregar logs o lanzar un error genérico)
            print("Error al obtener héroes: \(error.localizedDescription)")
        }
        
        return modelReturn
    }
    
    func getTransformations(heroId: String) async -> [TransformationsModel] {
        var modelReturn = [TransformationsModel]()
        
        let url: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.transformations.rawValue)"
        var request: URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(["heroId": heroId]) // Cuerpo de la solicitud con el ID del héroe
        
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        print()
        print("request\(request), heroId: \(heroId)")
        print()
        
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
            } else {
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

final class NetworkTransformationsMock: NetworkTransformationsProtocol {
    func getHeros(filter: String) async -> [HerosModel] {
        return getHerosHardcodedForTransformations()
    }

    func getTransformations(heroId: String) async -> [TransformationsModel] {
        return getTransformationsHardcoded(for: heroId)
    }
}

// Función para obtener héroes de manera simulada
func getHerosHardcodedForTransformations() -> [HerosModel] {
    let model1 = HerosModel(
        id: "1234",
        favorite: true,
        description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra...",
        photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
        name: "Goku"
    )

    let model2 = HerosModel(
        id: "123",
        favorite: true,
        description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable...",
        photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
        name: "Vegeta"
    )

    return [model1, model2]
}

// Función para obtener transformaciones de manera simulada
func getTransformationsHardcoded(for heroId: String) -> [TransformationsModel] {
    let heroGoku = HerosModel(
        id: "1234",
        favorite: true,
        description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra...",
        photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
        name: "Goku"
    )

    let heroVegeta = HerosModel(
        id: "123",
        favorite: true,
        description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable...",
        photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
        name: "Vegeta"
    )

    // Datos simulados de transformaciones
        let transformations = [
            TransformationsModel(
                id: "1",
                description: "Goku se transforma en Super Saiyan cuando su ira alcanza el límite...",
                photo: "https://example.com/super_saiyan.jpg",
                name: "Super Saiyan",
                hero: heroGoku
            ),
            TransformationsModel(
                id: "2",
                description: "Goku alcanza el Ultra Instinto, una técnica avanzada que solo los ángeles dominan...",
                photo: "https://example.com/ultra_instinto.jpg",
                name: "Ultra Instinto",
                hero: heroGoku
            ),
            TransformationsModel(
                id: "3",
                description: "Vegeta logra alcanzar el poder de Super Saiyan Blue después de un entrenamiento intenso...",
                photo: "https://example.com/super_saiyan_blue.jpg",
                name: "Super Saiyan Blue",
                hero: heroVegeta
            )
        ]

        // Filtrar transformaciones por heroId
        return transformations.filter { $0.hero?.id == heroId }
}


//import Foundation
//import QuinteroLibrary
//
//protocol NetworkTransformationsProtocol {
//    func getHeros(filter: String) async -> [HerosModel]
//    func getTransformations(heroId: String) async -> [TransformationsModel]
//}
//
//final class NetworkTransformations: NetworkTransformationsProtocol {
//    func getHeros(filter: String) async -> [HerosModel] {
//        var modelReturn = [HerosModel]()
//        
//        let url: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.heros.rawValue)"
//        var request: URLRequest = URLRequest(url: URL(string: url)!)
//        request.httpMethod = HTTPMethods.post
//        request.httpBody = try? JSONEncoder().encode(HeroModelRequest(name: filter))
//        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
//    
//        print()
//        print("urlhero:\(url) requestHero\(request), filter: \(filter), name: \(modelReturn)")
//        print()
//        
//        // Token JWT (extraer de aquí o usar un interceptor genérico)
//        let jwtToken = KeyChainManager.shared.getKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
//        if let tokenJWT = jwtToken {
//            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
//        }
//        
//        // Realizar la llamada al servidor
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//            
//            // Asegurarnos de que la respuesta sea HTTPURLResponse y que sea exitosa
//            if let resp = response as? HTTPURLResponse {
//                if resp.statusCode == HTTPResponseCodes.SUCCESS {
//                    modelReturn = try JSONDecoder().decode([HerosModel].self, from: data)
//                    print()
//                    print("urlhero:\(url) requestHero\(request), filter: \(filter), name: \(modelReturn)")
//                    print()
//                }
//            }
//        } catch {
//            // Manejo de errores (podrías agregar logs o lanzar un error genérico)
//            print("Error al obtener héroes: \(error.localizedDescription)")
//        }
//        
//        return modelReturn
//    }
//    
//    func getTransformations(heroId: String) async -> [TransformationsModel] {
//        var modelReturn = [TransformationsModel]()
//        
//        let url: String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.transformations.rawValue)"
//        var request: URLRequest = URLRequest(url: URL(string: url)!)
//        request.httpMethod = HTTPMethods.post
//        request.httpBody = try? JSONEncoder().encode(["heroId": heroId]) // Cuerpo de la solicitud con el ID del héroe
//        
//        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
//        
//        print()
//        print("request\(request), heroId: \(heroId)")
//        print()
//        
//        // Token JWT (extraer de aquí o usar un interceptor genérico)
//        let jwtToken = KeyChainManager.shared.getKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
//        if let tokenJWT = jwtToken {
//            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization")
//        }
//        
//        
//        
//        // Realizar la llamada al servidor
//        do {
//            let (data, response) = try await URLSession.shared.data(for: request)
//            
//            // Asegurarnos de que la respuesta sea HTTPURLResponse y que sea exitosa
//            if let resp = response as? HTTPURLResponse {
//                if resp.statusCode == HTTPResponseCodes.SUCCESS {
//                    modelReturn = try JSONDecoder().decode([TransformationsModel].self, from: data)
//                }
//            }else {
//                print("API Response Code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
//                print("API Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
//            }
//        } catch {
//            // Manejo de errores (puedes agregar logs o lanzar un error genérico)
//            print("Error al obtener transformaciones: \(error.localizedDescription)")
//        }
//        
//        return modelReturn
//    }
//}
//
//final class NetworkTransformationsMock: NetworkTransformationsProtocol {
//    func getHeros(filter: String) async -> [HerosModel] {
//        return getHerosHardcoded()
//    }
//
//    func getTransformations(heroId: String) async -> [TransformationsModel] {
//        return getTransformationsHardcoded(for: heroId)
//    }
//}
//
//// Función para obtener héroes de manera simulada
//func getHerosHardcodedForTransformations() -> [HerosModel] {
//    let model1 = HerosModel(
//        id: "1234",
//        favorite: true,
//        description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra...",
//        photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
//        name: "Goku"
//    )
//
//    let model2 = HerosModel(
//        id: "123",
//        favorite: true,
//        description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable...",
//        photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
//        name: "Vegeta"
//    )
//
//    return [model1, model2]
//}
//
//// Función para obtener transformaciones de manera simulada
//func getHerosHardcodedForTransformations() -> [TransformationsModel] {
//    return [
//        TransformationsModel(
//            id: "1",
//            description: "Goku se transforma en Super Saiyan cuando su ira alcanza el límite...",
//            photo: "https://example.com/super_saiyan.jpg",
//            name: "Super Saiyan",
//            hero: TransformationsModel.HeroReference(id: "1234")
//        ),
//        TransformationsModel(
//            id: "2",
//            description: "Goku alcanza el Ultra Instinto, una técnica avanzada que solo los ángeles dominan...",
//            photo: "https://example.com/ultra_instinto.jpg",
//            name: "Ultra Instinto",
//            hero: TransformationsModel.HeroReference(id: "1234")
//        ),
//        TransformationsModel(
//            id: "3",
//            description: "Vegeta logra alcanzar el poder de Super Saiyan Blue después de un entrenamiento intenso...",
//            photo: "https://example.com/super_saiyan_blue.jpg",
//            name: "Super Saiyan Blue",
//            hero: TransformationsModel.HeroReference(id: "123")
//        )
//    ]
//}





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


