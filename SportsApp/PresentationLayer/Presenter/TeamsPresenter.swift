//
//  TeamsPresenter.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

class TeamsPresenter {
    
    weak var teamsViewController : TeamsProtocol?
    let teamsUsecase : TeamsUsecaseProtocol
    
    init(teamsUsecase: TeamsUsecaseProtocol) {
        self.teamsUsecase = teamsUsecase
    }
    
    func setTableView(_ teamsViewController: TeamsProtocol) {
        self.teamsViewController = teamsViewController
    }
    
    func getTeams(map:Int, leagueId:Int){
        teamsUsecase.fetchTeams(map: map, leagueId: leagueId) { result, error in
            if let error = error{
                print("\(error.localizedDescription)")
            }
            guard let result = result else {
                self.teamsViewController?.renderTeams(result: nil)
                return
            }
            
            self.teamsViewController?.renderTeams(result: result)
        }
    }
    
}
