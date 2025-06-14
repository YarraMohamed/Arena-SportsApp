//
//  SplashViewController.swift
//  Arena
//
//  Created by Yara Mohamed on 20/05/2025.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = LottieAnimationView(name: AppStrings.Animation.lottie)
                animationView?.frame = view.bounds
                animationView?.contentMode = .scaleAspectFit
                animationView?.loopMode = .playOnce
                animationView?.animationSpeed = 1.5
        
        if let animationView = animationView {
               view.addSubview(animationView)
               animationView.play { [weak self] finished in
                   if finished {
                       self?.naviagteToOtherSceeen()
                   }
               }
           }
       }
    
    private func naviagteToOtherSceeen() {
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: StoryboardIDs.hasSeenOnboarding)
        
        if hasSeenOnboarding {
            goToMainView()
        }else{
            goToOnBoardingView()
        }
    }
}

