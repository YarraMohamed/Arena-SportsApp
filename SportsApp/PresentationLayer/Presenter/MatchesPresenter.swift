//
//  MatchesPresenter.swift
//  TestAPI
//
//  Created by Yara Mohamed on 17/05/2025.
//

import Foundation

class MatchesPresenter {
    
    weak var matchesViewController : MatchesCollectionViewController?
    let fixturesUsecase : FixturesUsecaseProtocol
    
    init(fixturesUsecase: FixturesUsecaseProtocol) {
        self.fixturesUsecase = fixturesUsecase
    }
    
    func setTableView(_ matchesViewController: MatchesCollectionViewController) {
        self.matchesViewController = matchesViewController
    }
    
    func getData(){
        fixturesUsecase.fetchFixtures(from: "2025-05-18", to: "2027-12-18", leagueId: "4") { result in
            self.matchesViewController?.renderView(result: result)
        }
    }
}
