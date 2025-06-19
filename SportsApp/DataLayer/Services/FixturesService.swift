//
//  FixturesService.swift
//  TestAPI
//
//  Created by Yara Mohamed on 16/05/2025.
//

import Foundation
import Alamofire

class FixturesService : FixtureServiceProtocol {
    
    func fetchFixturesFromAPI(map:Int,from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?, Error?) -> Void) {
        let url = urlMapper(id: map)
        let parameters: Parameters = [
            "met": "Fixtures",
            "APIkey": AppConstants.apiKey,
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
