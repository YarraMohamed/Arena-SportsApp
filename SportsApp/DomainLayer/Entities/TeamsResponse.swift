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
    let coaches : [Coach]?
    
    enum CodingKeys : String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
        case coaches
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

struct Coach : Decodable {
    let coachName : String?
    let coachCountry : String?
    
    enum CodingKeys : String, CodingKey {
        case coachName = "coach_name"
        case coachCountry = "coach_country"
    }
}
