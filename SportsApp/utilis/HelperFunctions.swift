//
//  HelperFunctions.swift
//  SportsApp
//
//  Created by Yara Mohamed on 13/05/2025.
//

import Foundation
import UIKit

func goToMainView(){
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    let mainVC = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "tabBar")
    
    if let window = windowScene?.windows.first {
        window.rootViewController = mainVC
        window.makeKeyAndVisible()
    }
}

func goToOnBoardingView(){
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    let mainVC = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "onBoarding")
    
    if let window = windowScene?.windows.first {
        window.rootViewController = mainVC
        window.makeKeyAndVisible()
    }
}

func currentDateFormatter() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let dateTimeString = formatter.string(from: Date())
    return dateTimeString
}

func futureDateFormatter() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    if let oneYearLater = Calendar.current.date(byAdding: .year, value: 1, to: Date()) {
        let formatted = formatter.string(from: oneYearLater)
        return formatted
    }
    return ""
}

func pastDateFormatter() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    if let oneYearLater = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
        let formatted = formatter.string(from: oneYearLater)
        return formatted
    }
    return ""
}

func pastYearDataFormatter() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"

    if let oneYearLater = Calendar.current.date(byAdding: .year, value: -1, to: Date()) {
        let formatted = formatter.string(from: oneYearLater)
        return formatted
    }
    return ""
}

func urlMapper(id:Int) ->String{
    switch id{
    case 1:
        return "https://apiv2.allsportsapi.com/football"
    case 2:
        return "https://apiv2.allsportsapi.com/basketball"
    case 3:
        return "https://apiv2.allsportsapi.com/cricket"
    default :
        return "https://apiv2.allsportsapi.com/tennis"
    }
}
