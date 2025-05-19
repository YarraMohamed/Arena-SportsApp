//
//  TopScorersResponse.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

struct TopScorersResponse: Decodable {
    let success : Int
    let result : [TopScorer]?
   
}

struct TopScorer : Decodable {
    let playerPlace : Int?
    let playerName : String?
    let teamLogo : String?
    let players : [Player]?
    
    enum CodingKeys : String, CodingKey {
        case playerPlace = "player_place"
        case playerName = "player_name"
        case teamLogo = "team_logo"
        case players
    }
}
