//
//  LeaguesService.swift
//  Arena
//
//  Created by MacBook on 18/05/2025.
//

import Foundation
import Alamofire

private let API_KEY = "978223e2ba1414ad957ef3bb3083dde031b4400d4b2c4d9ed6b42fb8c30cb5b3"

class LeaguesService : LeaguesServiceProtocol{
    
    func fetchLeaguesFromAPI(map: Int, completion: @escaping (LeaguesResponse?, Error?) -> Void) {
        let url = urlMapper(id: map)
        let parameters = [
            "met" : "Leagues",
            "APIkey" : API_KEY
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: LeaguesResponse.self) { response in
                switch response.result {
                case .success(let leaguesResponse):
                    completion(leaguesResponse, nil)
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
    }
    
}
