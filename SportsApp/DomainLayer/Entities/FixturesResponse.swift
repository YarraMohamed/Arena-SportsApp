//
//  FixturesResponse.swift
//  TestAPI
//
//  Created by Yara Mohamed on 17/05/2025.
//

import Foundation

struct FixturesResponse: Decodable {
    var result : [Fixtures]
    
    init(result: [Fixtures]) {
        self.result = result
    }
    
    enum CodingKeys: CodingKey {
        case result
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let resultData = try? container.decode([Fixtures].self, forKey: .result) else{
            self.result = []
            return
        }
        self.result = resultData
    }
}

struct Fixtures: Decodable {
    var date : String
    var time : String
    var opponentOne : String
    var opponentTwo : String
    var opponentOneLogo : String
    var opponentTwoLogo : String
    var score : String
    
    init(date: String, time: String, opponentOne: String, opponentTwo: String, opponentOneLogo: String, opponentTwoLogo: String, score: String){
        self.date = date
        self.time = time
        self.opponentOne = opponentOne
        self.opponentTwo = opponentTwo
        self.opponentOneLogo = opponentOneLogo
        self.opponentTwoLogo = opponentTwoLogo
        self.score = score
    }
    
    enum CodingKeys: String, CodingKey {
        case event_date
        case event_date_start
        case event_time
        case event_home_team
        case event_first_player
        case event_away_team
        case event_second_player
        case home_team_logo
        case event_home_team_logo
        case event_first_player_logo
        case event_second_player_logo
        case event_away_team_logo
        case away_team_logo
        case event_final_result
        case event_home_final_result
        
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let date = try? container.decode(String.self, forKey: .event_date) {
            self.date = date
        } else if let date = try? container.decode(String.self, forKey: .event_date_start) {
            self.date = date
        }else {
            date = ""
        }
        
        time = try container.decode(String.self, forKey: .event_time)
        
        if let opponentOneName = try? container.decode(String.self, forKey: .event_home_team) {
            opponentOne = opponentOneName
        } else if let opponentOneName = try? container.decode(String.self, forKey: .event_first_player) {
            opponentOne = opponentOneName
        }else{
            opponentOne = ""
        }
        
        if let opponentTwoName = try? container.decode(String.self, forKey: .event_away_team) {
            opponentTwo = opponentTwoName
        } else if let opponentTwoName = try? container.decode(String.self, forKey: .event_second_player) {
            opponentTwo = opponentTwoName
        }else{
            opponentTwo = ""
        }

        if let opponentOneLogo = try? container.decode(String.self, forKey: .home_team_logo) {
            self.opponentOneLogo = opponentOneLogo
        } else if let opponentOneLogo = try? container.decode(String.self, forKey: .event_home_team_logo) {
            self.opponentOneLogo = opponentOneLogo
        } else if let oppenentOneLogo = try? container.decode(String.self, forKey: .event_first_player_logo) {
            self.opponentOneLogo = oppenentOneLogo
        }else{
            opponentOneLogo=""
        }
        
        if let opponentTwoLogo = try? container.decode(String.self, forKey: .away_team_logo) {
            self.opponentTwoLogo = opponentTwoLogo
        } else if let opponentTwoLogo = try? container.decode(String.self, forKey: .event_away_team_logo) {
            self.opponentTwoLogo = opponentTwoLogo
        } else if let opponentTwoLogo = try? container.decode(String.self, forKey: .event_second_player_logo) {
            self.opponentTwoLogo = opponentTwoLogo
        }else{
            opponentTwoLogo = ""
        }
        
        if let score = try? container.decode(String.self, forKey: .event_final_result) {
            self.score = score
        } else if let score = try? container.decode(String.self, forKey: .event_home_final_result) {
            self.score = score
        }else{
            score = ""
        }
    }
}
