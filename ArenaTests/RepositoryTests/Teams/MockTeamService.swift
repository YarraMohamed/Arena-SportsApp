//
//  MockTeamService.swift
//  ArenaTests
//
//  Created by Yara Mohamed on 20/05/2025.
//

import Foundation
@testable import Arena

class MockTeamService: TeamsServiceProtocol {
    var shouldReturnError = false
    let mockResponse = TeamsResponse(success: 1, result: [
        Team(teamKey: 2,
             teamName: "test team",
             teamLogo: "team.png",
             players: [
                Player(playerKey: 2,
                       playerName: "test player",
                       playerType: "test type",
                       playerImage: "player.png")
                
             ])
    ])
    
    func fetchTeamsFromAPI(map: Int, leagueId: Int, completion: @escaping (Arena.TeamsResponse?, (any Error)?) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(nil, error)
        } else {
            completion(mockResponse, nil)
        }
    }
    
    
}
