//
//  PlayersService.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation
import Alamofire

private let API_KEY = "978223e2ba1414ad957ef3bb3083dde031b4400d4b2c4d9ed6b42fb8c30cb5b3"

class PlayersService : PlayersServiceProtocol{
    func fetchPlayersFromAPI(map: Int, teamId: Int, completion: @escaping (PlayersResponse?, Error?) -> Void) {
        let url = urlMapper(id: map)
        print("Team ID: \(teamId)")
        let parameters: Parameters = [
            "met": "Players",
            "teamId": teamId,
            "APIkey": API_KEY
        ]
        AF.request(url,parameters: parameters)
            .validate()
            .responseDecodable(of: PlayersResponse.self) { response in
                switch response.result{
                case .success(let players) :
                    print(players)
                    completion(players,nil)
                case .failure(let error) :
                    completion(nil,error)
                }
            }
    }
}
