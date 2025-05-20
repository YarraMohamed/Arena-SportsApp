//
//  PlayersRepositoryTests.swift
//  ArenaTests
//
//  Created by Yara Mohamed on 20/05/2025.
//

import XCTest
@testable import Arena

final class PlayersRepositoryTests: XCTestCase {

    var mockService : MockPlayersService!
    var repository : PlayersRepository!
    var teamId : Int?
    var leagueId : Int?
    
    override func setUpWithError() throws {
        mockService = MockPlayersService()
        repository = PlayersRepository(service: mockService)
        teamId = 164
        leagueId = 4
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetPlayersCaseSuccess() {
        repository.getPlayers(map: 1, teamId: teamId!) { res, err in
            XCTAssertNil(err)
            XCTAssertGreaterThan(res!.result!.count, 0)
        }
    }
    
    func testGetPlayersCaseFailure() {
        mockService.shouldReturnError = true
        repository.getPlayers(map: 1, teamId: teamId!) { res, err in
            XCTAssertNotNil(err)
            XCTAssertNil(res)
        }
    }
    
    func testGetTennisPlayersCaseSuccess() {
        repository.getTennisPlayers(map: 1, leagueId: leagueId!) { res, err in
            XCTAssertNil(err)
            XCTAssertTrue(res!.result!.count > 0)
        }
    }
    
    func testGetTennisPlayersCaseFailure() {
        mockService.shouldReturnError = true
        repository.getTennisPlayers(map: 1, leagueId: leagueId!) { res, err in
            XCTAssertNotNil(err)
            XCTAssertNil(res)
        }
    }


}
