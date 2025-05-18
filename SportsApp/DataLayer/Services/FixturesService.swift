//
//  FixturesService.swift
//  TestAPI
//
//  Created by Yara Mohamed on 16/05/2025.
//

import Foundation
import Alamofire

private let API_KEY = "978223e2ba1414ad957ef3bb3083dde031b4400d4b2c4d9ed6b42fb8c30cb5b3"

class FixturesService : FixtureServiceProtocol {
    
    func fetchFixturesFromAPI(map:Int,from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?, Error?) -> Void) {
        let url = urlMapper(id: map)
       // let url = "https://apiv2.allsportsapi.com/football"
        let parameters: Parameters = [
            "met": "Fixtures",
            "APIkey": API_KEY,
            "from": from,
            "to": to,
            "leagueId": leagueId
        ]
        AF.request(url,parameters: parameters)
            .validate()
            .responseDecodable(of: FixturesResponse.self) { response in
                switch response.result{
                case .success(let fixtures) :
                    completion(fixtures,nil)
                case .failure(let error) :
                    completion(nil,error)
                }
            }
    }
}
