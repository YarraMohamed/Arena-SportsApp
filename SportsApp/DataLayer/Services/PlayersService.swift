//
//  PlayersService.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation
import Alamofire

class PlayersService : PlayersServiceProtocol{
    
    func fetchPlayersFromAPI(map: Int, teamId: Int, completion: @escaping (PlayersResponse?, Error?) -> Void) {
        let url = urlMapper(id: map)
        print("Team ID: \(teamId)")
        let parameters: Parameters = [
            "met": "Players",
            "teamId": teamId,
            "APIkey": AppConstants.apiKey
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
    
    func fetchTennisPlayersFromAPI(map: Int, leagueId: Int, completion: @escaping (PlayersResponse?, (any Error)?) -> Void) {
        let url = urlMapper(id: map)
        let parameters: Parameters = [
            "met": "Players",
            "leagueId": leagueId,
            "APIkey": AppConstants.apiKey        ]
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
