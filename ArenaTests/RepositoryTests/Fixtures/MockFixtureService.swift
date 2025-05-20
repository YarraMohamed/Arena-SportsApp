//
//  MockFixtureService.swift
//  ArenaTests
//
//  Created by Yara Mohamed on 20/05/2025.
//

import Foundation
@testable import Arena

class MockFixtureService: FixtureServiceProtocol {
    var shouldReturnError = false
    let mockResponse = FixturesResponse(result: [
        Fixtures(
            date: "2025-05-20",
            time: "18:00",
            opponentOne: "Team A",
            opponentTwo: "Team B",
            opponentOneLogo: "logo1.png",
            opponentTwoLogo: "logo2.png",
            score: "2 - 1"
        )
    ])

    func fetchFixturesFromAPI(map: Int, from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?, Error?) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(nil, error)
        } else {
            completion(mockResponse, nil)
        }
    }
}
