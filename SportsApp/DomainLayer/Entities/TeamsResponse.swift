//
//  TeamsResponse.swift
//  Arena
//
//  Created by MacBook on 18/05/2025.
//

import Foundation

struct TeamsResponse: Decodable {
    let success : Int
    let result : [Team]?
   
}

struct Team : Decodable {
    let teamKey : Int?
    let teamName : String?
    let teamLogo : String?
    let players : [Player]?
    
    enum CodingKeys : String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
    }
}

struct Player : Decodable {
    let playerKey : Int?
    let playerName : String?
    let playerImage : String?
    
    enum CodingKeys : String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerImage = "player_image"
    }
}
