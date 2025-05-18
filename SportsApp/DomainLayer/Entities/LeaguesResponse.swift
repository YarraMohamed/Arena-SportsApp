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
}

struct League : Decodable {
    let leagueKey: Int
    let leagueName: String
    let leagueLogo: String?
    let countryName: String

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case countryName = "country_name"
    }
}
