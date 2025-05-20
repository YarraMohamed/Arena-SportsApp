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
    
    init(success:Int, result: [Team]) {
        self.success = success
        self.result = result
    }
}

struct Team : Decodable {
    let teamKey : Int?
    let teamName : String?
    let teamLogo : String?
    let players : [Player]?
    
    init(teamKey:Int, teamName:String, teamLogo:String, players:[Player]){
        self.teamKey = teamKey
        self.teamName = teamName
        self.teamLogo = teamLogo
        self.players = players
    }
    
    enum CodingKeys : String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
    }
}


