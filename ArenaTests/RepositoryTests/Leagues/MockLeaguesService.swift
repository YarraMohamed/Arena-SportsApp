//
//  MockLeaguesService.swift
//  ArenaTests
//
//  Created by Yara Mohamed on 20/05/2025.
//

import Foundation
@testable import Arena

class MockLeaguesService : LeaguesServiceProtocol{
    var shouldReturnError = false
    let mockResponse = LeaguesResponse(success: 1, result: [
        League(leagueKey: 3,
               leagueName: "test league",
               leagueLogo: "logo1.png",
               countryName: "test name")
    ])
    
    func fetchLeaguesFromAPI(map: Int, completion: @escaping (Arena.LeaguesResponse?, (any Error)?) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(nil, error)
        } else {
            completion(mockResponse, nil)
        }
    }
}
