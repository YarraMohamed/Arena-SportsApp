//
//  APIConstants.swift
//  Arena
//
//  Created by Sakir Saiyed on 2025-06-14.
//

enum API {
    static let baseURL = "https://apiv2.allsportsapi.com"
    
    enum Endpoint {
        static let football = "/football"
        static let basketball = "/basketball"
        static let cricket = "/cricket"
        static let tennis = "/tennis"
    }
    
    // Combine base + path
    static func url(for endpoint: String) -> String {
        return baseURL + endpoint
    }
}

