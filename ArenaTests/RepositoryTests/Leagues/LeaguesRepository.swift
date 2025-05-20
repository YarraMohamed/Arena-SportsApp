//
//  LeaguesRepository.swift
//  ArenaTests
//
//  Created by Yara Mohamed on 20/05/2025.
//

import XCTest
@testable import Arena

final class LeaguesRepositoryTests: XCTestCase {
    
    var mockService: MockLeaguesService!
    var repo : LeaguesRepository!
   
    override func setUpWithError() throws {
        mockService = MockLeaguesService()
        repo = LeaguesRepository(service: mockService)
    }
    
    func testGetLeaguesCaseSuccess() {
        repo.getLeagues(map: 1) { res, error in
            XCTAssertNil(error)
            XCTAssertEqual(res?.result.count, 1)
        }
    }
    
    func testGetLeaguesCaseFailure() {
        mockService.shouldReturnError = true
        repo.getLeagues(map: 1) { res, err in
            XCTAssertNotNil(err)
            XCTAssertNil(res)
        }        
    }

}
