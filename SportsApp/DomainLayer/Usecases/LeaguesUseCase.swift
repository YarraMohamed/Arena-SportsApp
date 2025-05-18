//
//  LeaguesUseCase.swift
//  Arena
//
//  Created by MacBook on 18/05/2025.
//

import Foundation

class LeaguesUseCase : LeaguesUsecaseProtocol {

    let repo : LeaguesRepositoryProtocol
    init(repo: LeaguesRepositoryProtocol) {
        self.repo = repo
    }
    
    func fetchLeagues(map: Int, completion: @escaping (LeaguesResponse?, Error?) -> Void) {
        repo.getLeagues(map: map) { response, error in
            if let error = error {
                completion(nil, error)

            }
            
            guard let response = response else{
                completion(nil, error)
                return
            }
            
            completion(response, nil)
        }
    }
}
