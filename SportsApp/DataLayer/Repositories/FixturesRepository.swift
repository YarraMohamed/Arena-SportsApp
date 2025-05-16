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
    
    func getFixtures(from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?) -> Void) {
        service.fetchFixturesFromAPI(from: from, to: to, leagueId: leagueId) { fixtures in
            guard let fixtures = fixtures else {
                completion(nil)
                return
            }
            completion(fixtures)
        }
    }
    
    
}
