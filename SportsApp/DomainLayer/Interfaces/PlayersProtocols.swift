//
//  PlayersProtocols.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

protocol PlayersServiceProtocol {
    func fetchPlayersFromAPI(map:Int, teamId:Int, completion: @escaping (PlayersResponse?, Error?) -> Void)
    func fetchTennisPlayersFromAPI(map:Int, leagueId:Int, completion: @escaping (PlayersResponse?, Error?) -> Void)
}

protocol PlayersRepositoryProtocol {
    func getPlayers(map:Int, teamId:Int, completion: @escaping (PlayersResponse?, Error?) -> Void)
    func getTennisPlayers(map:Int, leagueId:Int, completion: @escaping (PlayersResponse?, Error?) -> Void)
}

protocol PlayersUsecaseProtocol {
    func fetchPlayers(map:Int, teamId:Int, completion: @escaping (PlayersResponse?, Error?) -> Void)
    func fetchTennisPlayers(map:Int, leagueId:Int, completion: @escaping (PlayersResponse?, Error?) -> Void)
}

