//
//  FixturesProtocols.swift
//  TestAPI
//
//  Created by Yara Mohamed on 17/05/2025.
//

import Foundation

protocol FixtureServiceProtocol {
    func fetchFixturesFromAPI(from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?) -> Void)
}

protocol FixturesRepositoryProtocol {
    func getFixtures(from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?) -> Void)
    
}

protocol FixturesUsecaseProtocol {
    func fetchFixtures(from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?) -> Void)
}
