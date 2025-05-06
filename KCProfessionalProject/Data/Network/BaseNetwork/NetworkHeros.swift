//
//  NetworkHeros.swift
//  KCProfessionalProject
//
//  Created by Luis Quintero on 30/04/25.
//

import Foundation
import QuinteroLibrary

protocol NetworkHerosProtocol {
    func getHeros(filter: String) async -> [HerosModel]
}


final class NetworkHeros: NetworkHerosProtocol{
    func getHeros(filter: String) async -> [HerosModel] {
        var modelReturn = [HerosModel]()
        
        let url : String = "\(ConstantsApp.CONST_API_URL)\(EndPoints.heros.rawValue)"
        var request : URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(HeroModelRequest(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
    
        //Token JWT (habría que extraer de aqui) a algo generico o interceptor
        let JwtToken =  KeyChainManager.shared.getKC(key: ConstantsApp.CONST_TOKEN_ID_KEYCHAIN)
        if let tokenJWT = JwtToken{
            request.addValue("Bearer \(tokenJWT)", forHTTPHeaderField: "Authorization") //Token
        }
        
        //Call to server
        do{
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Asegurarnos que la respuesta sea HTTPURLResponse y que sea correcta
            if let resp = response  as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    modelReturn = try! JSONDecoder().decode([HerosModel].self, from: data)
                }
            }
            
        }catch{
            
        }
        
        return modelReturn
    }
}

// Para tests
final class NetworkHerosMock: NetworkHerosProtocol{
    func getHeros(filter: String) async -> [HerosModel] {
        return getHerosHardcoded()
    }
}


 func getHerosFromJson() -> [HerosModel] {
    if let url = Bundle.main.url(forResource: "heros", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([HerosModel].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return []
}

func getHerosHardcoded() -> [HerosModel] {
    let model1 = HerosModel(id: "1234",
                            favorite: true,
                            description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",
                            photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300",
                            name: "Goku")

   let model2 = HerosModel(id: "123",
                           favorite: true,
                           description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.",
                           photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300",
                           name: "Vegeta")

   return [model1, model2]
}

