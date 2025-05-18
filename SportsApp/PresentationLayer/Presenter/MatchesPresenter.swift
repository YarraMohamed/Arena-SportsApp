//
//  MatchesPresenter.swift
//  TestAPI
//
//  Created by Yara Mohamed on 17/05/2025.
//

import Foundation

class MatchesPresenter {
    
    weak var matchesViewController : MatchesProtocol?
    let fixturesUsecase : FixturesUsecaseProtocol
    
    init(fixturesUsecase: FixturesUsecaseProtocol) {
        self.fixturesUsecase = fixturesUsecase
    }
    
    func setTableView(_ matchesViewController: MatchesProtocol) {
        self.matchesViewController = matchesViewController
    }
    
    func getUpcomingMatches(map:Int, from:String, to:String, leagueId:String){
        fixturesUsecase.fetchFixtures(map:map, from:from, to: to, leagueId: leagueId) { result, err in
            if let err = err{
                print("\(err.localizedDescription)")
            }
            guard let result = result else {
                self.matchesViewController?.renderUpcomingMatches(result: nil)
                return
            }
            
            self.matchesViewController?.renderUpcomingMatches(result: result)
        }
    }
    
    func getPastMatches(map:Int, from:String, to:String, leagueId:String){
        fixturesUsecase.fetchFixtures(map:map,from:from, to: to, leagueId: leagueId) { result, err in
            if let err = err{
                print("\(err.localizedDescription)")
            }
            guard let result = result else {
                self.matchesViewController?.renderPastMatches(result: nil)
                return
            }
            
            self.matchesViewController?.renderPastMatches(result: result)
        }
    }
}
