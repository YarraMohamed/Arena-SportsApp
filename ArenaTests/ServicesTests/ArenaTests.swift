//
//  ArenaTests.swift
//  ArenaTests
//
//  Created by Yara Mohamed on 20/05/2025.
//

import XCTest
@testable import Arena

final class ArenaTests: XCTestCase {
    
    var fixtureService : FixturesService!
    var leaguesService: LeaguesService!
    var playerService : PlayersService!
    var teamService : TeamsService!
    
    override func setUpWithError() throws {
        fixtureService = FixturesService()
        leaguesService = LeaguesService()
        playerService = PlayersService()
        teamService = TeamsService()
    }
    
    override func tearDownWithError() throws {
    }
    
    // MARK: FixtureService
    func testFetchFixturesFromAPIFootballCase() throws {
        let expectation = self.expectation(description: "Fetch fixtures")
        
        let from = currentDateFormatter()
        let to = futureDateFormatter()
        let leagueId: String = "4"
        
        fixtureService.fetchFixturesFromAPI(map: 1, from: from, to: to, leagueId: leagueId) { res, err in
            if let error = err{
                XCTFail("\(error.localizedDescription)")
            }
            
            guard let fixtures = res else{
                XCTFail("Fixtures is nil")
                return
            }
            
            XCTAssertGreaterThan(fixtures.result.count, 0)
            XCTAssertNotNil(fixtures.result)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20)
        
    }
    
    func testFetchFixturesFromAPIBasketballCase() throws {
        let expectation = self.expectation(description: "Fetch fixtures")
        
        let from = currentDateFormatter()
        let to = futureDateFormatter()
        let leagueId: String = "766"
        
        fixtureService.fetchFixturesFromAPI(map: 2, from: from, to: to, leagueId: leagueId) { res, err in
            if let error = err{
                XCTFail("\(error.localizedDescription)")
            }
            
            guard let fixtures = res else{
                XCTFail("Fixtures is nil")
                return
            }
            
            XCTAssertGreaterThan(fixtures.result.count, 0)
            XCTAssertNotNil(fixtures.result)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30)
        
    }
    
    // MARK: LeaguesService
    func testFetchLeaguesFromAPI(){
        let expectation = expectation(description: "Fetching leagues")
        
        leaguesService.fetchLeaguesFromAPI(map: 1) { res, err in
            if let err = err {
                XCTFail("\(err.localizedDescription)")
            }
            guard let leagues = res else {
                XCTFail("No leagues returned")
                return
            }
            XCTAssertNotNil(leagues.result)
            XCTAssertGreaterThan(leagues.result.count, 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 20)
        
    }
    
    func testFetchLeaguesFromAPIBasketballCase() throws {
        let expectation = self.expectation(description: "Fetch leagues")
        leaguesService.fetchLeaguesFromAPI(map: 2) { res, err in
            if let error = err{
                XCTFail("\(error.localizedDescription)")
            }
            
            guard let leagues = res else{
                XCTFail("Fixtures is nil")
                return
            }
            
            XCTAssertGreaterThan(leagues.result.count, 0)
            XCTAssertNotNil(leagues.result)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20)
        
    }
    
    // MARK: PlayerService
    
    func testfFetchPlayersFromAPI(){
        let expectation = self.expectation(description: "Fetch players")
        let teamId = 164
        playerService.fetchPlayersFromAPI(map: 1, teamId: teamId) { res, err in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
            guard let res = res else {
                XCTFail("No players returned")
                return
            }
            XCTAssertEqual(res.result?.count, 36)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20)
    }
    
    func testFetchTennisPlayersFromAPI(){
        let expectation = self.expectation(description: "Fetch players")
        
        let leagueId = 2626
        playerService.fetchTennisPlayersFromAPI(map: 4, leagueId: leagueId) { res, err in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
            guard let res = res else {
                XCTFail("No players returned")
                return
            }
            XCTAssertEqual(res.result?.count, 33)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20)
    }
    
    // MARK: TeamService
    func testFetchTeamsFromAPI(){
        let expectation = self.expectation(description: "Fetch teams")
        let leagueId = 4
        teamService.fetchTeamsFromAPI(map: 1, leagueId: leagueId) { res, err in
            if let err = err {
                XCTFail(err.localizedDescription)
            }
            guard let res = res else {
                XCTFail("No players returned")
                return
            }
            XCTAssertNotNil(res.result)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20)
    }
}
