//
//  ViewProtocol.swift
//  Arena
//
//  Created by Yara Mohamed on 17/05/2025.
//

import Foundation

protocol MatchesProtocol : AnyObject {
    func renderUpcomingMatches(result: FixturesResponse?)
    func renderPastMatches(result: FixturesResponse?)
}
