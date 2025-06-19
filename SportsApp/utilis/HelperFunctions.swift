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
    let mainVC = UIStoryboard(name: StoryboardIDs.main, bundle: nil)
        .instantiateViewController(withIdentifier: AppTabBarItems.tabBar)
    
    if let window = windowScene?.windows.first {
        window.rootViewController = mainVC
        window.makeKeyAndVisible()
    }
}

func goToOnBoardingView(){
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    let mainVC = UIStoryboard(name: StoryboardIDs.main, bundle: nil)
        .instantiateViewController(withIdentifier: StoryboardIDs.onBoarding)
    
    if let window = windowScene?.windows.first {
        window.rootViewController = mainVC
        window.makeKeyAndVisible()
    }
}

func currentDateFormatter() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = AppStrings.General.dateFormat
    let dateTimeString = formatter.string(from: Date())
    return dateTimeString
}

func futureDateFormatter() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = AppStrings.General.dateFormat

    if let oneYearLater = Calendar.current.date(byAdding: .year, value: 1, to: Date()) {
        let formatted = formatter.string(from: oneYearLater)
        return formatted
    }
    return ""
}

func pastDateFormatter() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = AppStrings.General.dateFormat

    if let oneYearLater = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
        let formatted = formatter.string(from: oneYearLater)
        return formatted
    }
    return ""
}

func pastYearDataFormatter() -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = AppStrings.General.dateFormat

    if let oneYearLater = Calendar.current.date(byAdding: .year, value: -1, to: Date()) {
        let formatted = formatter.string(from: oneYearLater)
        return formatted
    }
    return ""
}

func urlMapper(id:Int) ->String{
    switch id{
    case 1:
        return API.url(for: API.Endpoint.football)
    case 2:
        return API.url(for: API.Endpoint.basketball)
    case 3:
        return API.url(for: API.Endpoint.cricket)
    default :
        return API.url(for: API.Endpoint.tennis)
    }
}
