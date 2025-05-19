//
//  TeamsRepository.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

class TeamsRepository : TeamsRepositoryProtocol{
    
    let service : TeamsServiceProtocol
    init(service: TeamsServiceProtocol) {
        self.service = service
    }
    
    func getTeams(map: Int, leagueId: Int, completion: @escaping (TeamsResponse?, Error?) -> Void) {
        service.fetchTeamsFromAPI(map: map, leagueId: leagueId) { response, error in
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
