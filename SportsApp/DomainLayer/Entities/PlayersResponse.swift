//
//  PlayersResponse.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

struct PlayersResponse: Decodable {
    let result : [Player]?
    
    enum CodingKeys: CodingKey {
        case result
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let result = try? container.decode([Player].self, forKey: .result) else{
            self.result = []
            return
        }
        self.result = result
    }
}

struct Player: Decodable {
    let playerKey: Int?
    let playerName: String?
    let playerType: String? // Optional since it might be missing
    let playerImage: String?
    
    enum CodingKeys: String, CodingKey {
        case player_image
        case player_logo
        case player_key
        case player_name
        case player_type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Handle player_image/player_logo
        if let image = try? container.decode(String.self, forKey: .player_image) {
            self.playerImage = image
        } else if let logo = try? container.decode(String.self, forKey: .player_logo) {
            self.playerImage = logo
        } else {
            playerImage = nil // Or set a default placeholder
        }
        
        // Decode mandatory fields
        playerKey = try container.decode(Int.self, forKey: .player_key)
        playerName = try container.decode(String.self, forKey: .player_name)
        
        // Handle optional player_type
        playerType = try? container.decode(String.self, forKey: .player_type)
    }
}
