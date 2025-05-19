//
//  TeamsProtocols.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

protocol TeamsServiceProtocol {
    func fetchTeamsFromAPI(map:Int, leagueId:Int, completion: @escaping (TeamsResponse?, Error?) -> Void)
}

protocol TeamsRepositoryProtocol {
    func getTeams(map:Int, leagueId:Int, completion: @escaping (TeamsResponse?, Error?) -> Void)
}

protocol TeamsUsecaseProtocol {
    func fetchTeams(map:Int, leagueId:Int, completion: @escaping (TeamsResponse?, Error?) -> Void)
}
