//
//  MockPlayersService.swift
//  ArenaTests
//
//  Created by Yara Mohamed on 20/05/2025.
//

import Foundation
@testable import Arena

class MockPlayersService: PlayersServiceProtocol {
    var shouldReturnError = false
    let mockResponse = PlayersResponse(result: [
        Player(playerKey: 2,
               playerName: "test player",
               playerType: "test player logo",
               playerImage: "player.png")
    ])
    
    func fetchPlayersFromAPI(map: Int, teamId: Int, completion: @escaping (Arena.PlayersResponse?, (any Error)?) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(nil, error)
        } else {
            completion(mockResponse, nil)
        }
    }
    
    func fetchTennisPlayersFromAPI(map: Int, leagueId: Int, completion: @escaping (Arena.PlayersResponse?, (any Error)?) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(nil, error)
        } else {
            completion(mockResponse, nil)
        }
    }
    
    
}
