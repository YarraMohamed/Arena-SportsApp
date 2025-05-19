//
//  PlayersRepository.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

class PlayersRepository : PlayersRepositoryProtocol{
    
    let service : PlayersServiceProtocol
    init(service: PlayersServiceProtocol) {
        self.service = service
    }
    
    func getPlayers(map: Int, teamId: Int, completion: @escaping (PlayersResponse?, (any Error)?) -> Void) {
        service.fetchPlayersFromAPI(map: map, teamId: teamId) { response, error in
            if let error = error {
                completion(nil,error)
            }
            guard let response = response else {
                completion(nil,error)
                return
            }
            completion(response,nil)
        }
    }
    
    func getTennisPlayers(map: Int, leagueId: Int, completion: @escaping (PlayersResponse?, (any Error)?) -> Void) {
        service.fetchTennisPlayersFromAPI(map: map, leagueId: leagueId) { response, error in
            if let error = error {
                completion(nil,error)
            }
            guard let response = response else {
                completion(nil,error)
                return
            }
            completion(response,nil)
        }
    }

}
