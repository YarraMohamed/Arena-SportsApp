//
//  FixturesProtocols.swift
//  TestAPI
//
//  Created by Yara Mohamed on 17/05/2025.
//

import Foundation

protocol FixtureServiceProtocol {
    func fetchFixturesFromAPI(map:Int, from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?, Error?) -> Void)
}

protocol FixturesRepositoryProtocol {
    func getFixtures(map:Int, from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?, Error?) -> Void)
    
}

protocol FixturesUsecaseProtocol {
    func fetchFixtures(map:Int, from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?, Error?) -> Void)
}
