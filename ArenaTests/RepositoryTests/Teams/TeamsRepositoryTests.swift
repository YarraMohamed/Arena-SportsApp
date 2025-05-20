//
//  TeamsRepositoryTests.swift
//  ArenaTests
//
//  Created by Yara Mohamed on 20/05/2025.
//

import XCTest
@testable import Arena

final class TeamsRepositoryTests: XCTestCase {
    var mockService: MockTeamService!
    var repo : TeamsRepository!
    var leagueId : Int!
    
    override func setUpWithError() throws {
       mockService = MockTeamService()
        repo = TeamsRepository(service: mockService)
        leagueId = 4
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetLeaguesCaseSuccess() {
        repo.getTeams(map: 1, leagueId: leagueId) { res, err in
            XCTAssertNil(err)
            XCTAssertEqual(res!.result!.count, 1)
        }
    }
    
    func testGetLeaguesCaseFailure() {
        mockService.shouldReturnError = true
        repo.getTeams(map: 2, leagueId: 4) { res, err in
            XCTAssertNotNil(err)
            XCTAssertNil(res)
        }
    }


}
