//
//  PlayersPresenter.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

class PlayersPresenter {
    
    weak var playersViewController : PlayersProtocol?
    let playersUsecase : PlayersUsecaseProtocol
    
    init(playersUsecase: PlayersUsecaseProtocol) {
        self.playersUsecase = playersUsecase
    }
    
    func setTableView(_ playersViewController: PlayersProtocol) {
        self.playersViewController = playersViewController
    }
    
    func getPlayers(map:Int, teamId:Int){
        playersUsecase.fetchPlayers(map: map, teamId: teamId) { result, error in
            if let error = error{
                print("\(error.localizedDescription)")
            }
            guard let result = result else {
                self.playersViewController?.renderPlayers(result: nil)
                return
            }
            
            self.playersViewController?.renderPlayers(result: result)
        }
    }
    
}
