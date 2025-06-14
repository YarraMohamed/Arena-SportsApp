//
//  TeamsService.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation
import Alamofire

class TeamsService : TeamsServiceProtocol {
    func fetchTeamsFromAPI(map: Int, leagueId: Int, completion: @escaping (TeamsResponse?, Error?) -> Void) {
        let url = urlMapper(id: map)
        print("League ID: \(leagueId)")
        let parameters: Parameters = [
            "met": "Teams",
            "leagueId": leagueId,
            "APIkey": Constants.apiKey
        ]
                AF.request(url,parameters: parameters)
                    .validate()
                    .responseDecodable(of: TeamsResponse.self) { response in
                        switch response.result{
                        case .success(let teams) :
                            print(teams)
                            completion(teams,nil)
                        case .failure(let error) :
                            completion(nil,error)
                        }
                    }
        
        
//        AF.request(url, parameters: parameters)
//            .validate()
//            .response { response in
//                switch response.result {
//                case .success(let data):
//                    // Print raw JSON response
//                    if let data = data {
//                        print("Raw JSON: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
//                    }
//                    // Attempt decoding
//                    do {
//                        let decodedResponse = try JSONDecoder().decode(TeamsResponse.self, from: data!)
//                        completion(decodedResponse, nil)
//                    } catch {
//                        print("Decoding Error: \(error)")
//                        completion(nil, error)
//                    }
//                case .failure(let error):
//                    print("API Request Error: \(error)")
//                    completion(nil, error)
//                }
//            }
    }
    
}

