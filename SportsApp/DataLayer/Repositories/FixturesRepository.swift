//
//  FixturesRepository.swift
//  TestAPI
//
//  Created by Yara Mohamed on 17/05/2025.
//

import Foundation

class FixturesRepository : FixturesRepositoryProtocol {
    
    let service : FixtureServiceProtocol
    init(service: FixtureServiceProtocol) {
        self.service = service
    }
    
    func getFixtures(map:Int, from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?, Error?) -> Void) {
        service.fetchFixturesFromAPI(map:map, from: from, to: to, leagueId: leagueId) { fixtures, err in
            if let err = err {
                completion(nil,err)
            }
            guard let fixtures = fixtures else {
                completion(nil,err)
                return
            }
            completion(fixtures,nil)
        }
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
