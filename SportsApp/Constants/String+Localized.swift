//
//  String+Localized.swift
//  Arena
//
//  Created by Sakir Saiyed on 2025-06-19.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

struct L10n {
    struct Common {
        static let ok = "ok".localized
        static let cancel = "cancel".localized
        static let sports_header = "SPORTS_HEADER".localized
        static let leagues_header = "LEAGUES_HEADER".localized
    }

    struct Games {
        static let FOOTBALL = "FOOTBALL".localized
        static let BASKETBALL = "BASKETBALL".localized
        static let CRICKET = "CRICKET".localized
        static let TENNIS = "TENNIS".localized
    }
}
