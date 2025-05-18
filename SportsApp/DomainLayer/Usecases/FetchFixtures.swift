//
//  FetchFixtures.swift
//  TestAPI
//
//  Created by Yara Mohamed on 17/05/2025.
//

import Foundation

class FetchFixtures : FixturesUsecaseProtocol {
    
    let repo : FixturesRepositoryProtocol
    init(repo: FixturesRepositoryProtocol) {
        self.repo = repo
    }
    
    func fetchFixtures(map:Int,from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?, Error?) -> Void) {
        repo.getFixtures(map:map, from: from, to: to, leagueId: leagueId) { res, err in
            if let err = err {
                completion(nil,err)
            }
            guard let res = res else{
                completion(nil,err)
                return
            }
            completion(res,nil)
        }
    }
    

    func fetchTeams(map: Int, leagueId: Int, completion: @escaping (TeamsResponse?, Error?) -> Void) {
        repo.getTeams(map: map, leagueId: leagueId) { response, error in
            if let error = error {
                completion(nil, error)
            }
            guard let response = response else {
                completion(nil, error)
                return
            }
            completion(response, nil)
        }
    }
}
