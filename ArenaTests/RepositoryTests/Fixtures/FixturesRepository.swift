//
//  FixturesRepository.swift
//  ArenaTests
//
//  Created by Yara Mohamed on 20/05/2025.
//

import XCTest
@testable import Arena

final class FixturesRepositoryTests: XCTestCase {
    
    var mockService: MockFixtureService!
    var repo : FixturesRepository!
    var from : String!
    var to : String!
    
    override func setUpWithError() throws {
        mockService = MockFixtureService()
        repo = FixturesRepository(service: mockService)
        from = currentDateFormatter()
        to = futureDateFormatter()
        
    }

    func testGetFixturesCaseSuccess() {
        repo.getFixtures(map: 1, from: from, to: to, leagueId: "4") { res, error in
            XCTAssertNil(error)
            XCTAssertEqual(res?.result.count, 1)
        }
    }
    
    func testGetFixturesCaseFailure() {
        mockService.shouldReturnError = true
        repo.getFixtures(map: 1, from: from, to: to, leagueId: "4") { res, err in
            XCTAssertNotNil(err)
            XCTAssertNil(res)
        }
        
    }
}

