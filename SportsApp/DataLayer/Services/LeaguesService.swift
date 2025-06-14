//
//  LeaguesService.swift
//  Arena
//
//  Created by MacBook on 18/05/2025.
//

import Foundation
import Alamofire

class LeaguesService : LeaguesServiceProtocol{
    
    func fetchLeaguesFromAPI(map: Int, completion: @escaping (LeaguesResponse?, Error?) -> Void) {
        let url = urlMapper(id: map)
        let parameters = [
            "met" : "Leagues",
            "APIkey" : Constants.apiKey
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
