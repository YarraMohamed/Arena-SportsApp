//
//  PlayersUseCase.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

class PlayersUseCase : PlayersUsecaseProtocol {
    
    let repo : PlayersRepositoryProtocol
    init(repo: PlayersRepositoryProtocol) {
        self.repo = repo
    }
    
    func fetchPlayers(map: Int, teamId: Int, completion: @escaping (PlayersResponse?, (any Error)?) -> Void) {
        repo.getPlayers(map: map, teamId: teamId) { response, error in
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
