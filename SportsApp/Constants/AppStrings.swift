//
//  AppStrings.swift
//  Arena
//
//  Created by Sakir Saiyed on 2025-06-14.
//

import Foundation

enum AppStrings {
    
    enum General {
        static let ok = "OK"
        static let cancel = "Cancel"
        static let loading = "Loading..."
        static let dateFormat = "yyyy-MM-dd"
        static let defaultConfiguration = "Default Configuration"
        static let search_leagues = "Search Leagues"
    }
    
    enum Errors {
        static let networkError = "Network connection lost."
        static let serverError = "Server error. Please try again later."
    }
    
    enum Animation {
        static let lottie = "lottie"
        
    }
    
    enum Localization {
        static let english = "English"
        static let french = "Français"
    }
    
    enum GameNames {
        static let football = "football"
        static let basketball = "basketball"
        static let cricket = "cricket"
        static let tennis = "tennis"
        
    }
    
    enum ImageNames{
        static let leaguePlaceholder = "leaguePlaceholder"
    }
    
    enum PlaceholderImageNames{
        static let leagueLogo = "https://static.becharge.be/img/be/placeholder.png"
        
    }
}
