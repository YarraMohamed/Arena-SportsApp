//
//  LeaguesProtocol.swift
//  Arena
//
//  Created by MacBook on 18/05/2025.
//

import Foundation

protocol LeaguesServiceProtocol {
    func fetchLeaguesFromAPI(map:Int, completion: @escaping (LeaguesResponse?, Error?) -> Void)
}

protocol LeaguesRepositoryProtocol{
    func getLeagues(map:Int, completion: @escaping (LeaguesResponse?, Error?) -> Void)
}

protocol LeaguesUsecaseProtocol{
    func fetchLeagues(map:Int, completion: @escaping (LeaguesResponse?, Error?) -> Void)
}


