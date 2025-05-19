//
//  TeamsUseCase.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

class TeamsUseCase : TeamsUsecaseProtocol{
    
    let repo : TeamsRepositoryProtocol
    init(repo: TeamsRepositoryProtocol) {
        self.repo = repo
    }
    
    func fetchTeams(map: Int, leagueId: Int, completion: @escaping (TeamsResponse?, Error?) -> Void) {
        repo.getTeams(map: map, leagueId: leagueId) { response, error in
            if let error = error {
                completion(nil, error)
            }
            guard let response = response else {
                completion(nil, error)
                return
            }
            completion(response, nil)
        }
    }

}
