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
    
    func fetchFixtures(from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?, Error?) -> Void) {
        repo.getFixtures(from: from, to: to, leagueId: leagueId) { res, err in
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

//
//    let repo : FixturesRepositoryProtocol
//    
//    init(repo : FixturesRepositoryProtocol) {
//        self.repo = repo
//    }
//    
//    func fetchFixtures(from: String, to: String, leagueId: String, completion: @escaping (FixturesResponse?) -> Void) {
//        repo.getFixtures(from: from, to: to, leagueId: leagueId) { fixtures in
//            guard let fixtures = fixtures else {
//                completion(nil)
//                return
//            }
//            completion(fixtures)
//        }
//    }
}
