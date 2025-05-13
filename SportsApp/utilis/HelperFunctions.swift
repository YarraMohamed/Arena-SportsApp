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
