//
//  FixturesResponse.swift
//  TestAPI
//
//  Created by Yara Mohamed on 17/05/2025.
//

import Foundation

struct FixturesResponse: Decodable {
    var result : [Fixtures]
}

struct Fixtures: Decodable {
    var event_date: String
    var event_time: String
    var event_home_team: String
    var event_away_team: String
    var home_team_logo: String
    var away_team_logo: String
}
