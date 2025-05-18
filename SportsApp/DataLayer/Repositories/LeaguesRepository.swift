//
//  LeaguesRepository.swift
//  Arena
//
//  Created by MacBook on 18/05/2025.
//

import Foundation

class LeaguesRepository : LeaguesRepositoryProtocol {
    
    let service : LeaguesServiceProtocol
    init(service: LeaguesServiceProtocol) {
        self.service = service
    }
    func getLeagues(map: Int, completion: @escaping (LeaguesResponse?, Error?) -> Void) {
        service.fetchLeaguesFromAPI(map: map) { response, error in
            if let error = error{
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
