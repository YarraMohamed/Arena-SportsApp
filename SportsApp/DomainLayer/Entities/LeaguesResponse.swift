//
//  LeaguesResponse.swift
//  Arena
//
//  Created by MacBook on 18/05/2025.
//

import Foundation

struct LeaguesResponse: Decodable {
    let success: Int
    let result: [League]
    
    init(success:Int, result: [League]) {
        self.success = success
        self.result = result
    }
}

struct League : Decodable {
    let leagueKey: Int
    let leagueName: String
    let leagueLogo: String?
    let countryName: String
    
    init(leagueKey:Int, leagueName:String, leagueLogo:String, countryName:String ){
        self.leagueKey = leagueKey
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
        self.countryName = countryName
    }

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case countryName = "country_name"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.leagueKey = try container.decode(Int.self, forKey: .leagueKey)
        self.leagueName = try container.decode(String.self, forKey: .leagueName)
        self.leagueLogo = try container.decodeIfPresent(String.self, forKey: .leagueLogo)
        if let countryName = try? container.decode(String.self, forKey: .countryName) {
            self.countryName = countryName
        } else {
            self.countryName = ""
        }
    }
}
