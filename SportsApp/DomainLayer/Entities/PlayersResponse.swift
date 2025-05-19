//
//  PlayersResponse.swift
//  Arena
//
//  Created by MacBook on 19/05/2025.
//

import Foundation

struct PlayersResponse: Decodable {
    let success : Int
    let result : [Player]?
}
