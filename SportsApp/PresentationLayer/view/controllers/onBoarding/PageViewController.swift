//
//  PageViewController.swift
//  SportsApp
//
//  Created by Yara Mohamed on 13/05/2025.
//

import UIKit

class PageViewController: UIPageViewController,
                          UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var arrContainer = [UIViewController]()
    var pageController = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "v1")
        let v2 = self.storyboard?.instantiateViewController(withIdentifier: "v2")
        let v3 = self.storyboard?.instantiateViewController(withIdentifier: "v3")
        
        guard let v1 = v1 , let v2 = v2 , let v3 = v3 else { return }
        
        arrContainer.append(v1)
        arrContainer.append(v2)
        arrContainer.append(v3)
        
        if let v1 = arrContainer.first {
            setViewControllers([v1], direction: .forward, animated: true)
        }
        
        delegate = self
        dataSource = self

        setupPageControl()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = arrContainer.firstIndex(of: viewController) else { return nil }
        
        if currentIndex > 0 {
            let prevIndex = currentIndex - 1
            return arrContainer[prevIndex]
        }else{
            return nil
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        guard let currentIndex = arrContainer.firstIndex(of: viewController) else { return nil }
       
        let nextIndex = currentIndex + 1
        if nextIndex >= arrContainer.count  {
            goToMainView()
            return nil
        }

        return arrContainer[nextIndex]
    }

    
    func setupPageControl(){
        
        pageController = UIPageControl(frame: CGRect(x: 0,
                                                     y: UIScreen.main.bounds.maxY - 250,
                                                     width: UIScreen.main.bounds.width,
                                                     height: 50))
        
        pageController.currentPage = 0
        pageController.numberOfPages = arrContainer.count
        pageController.tintColor = #colorLiteral(red: 0.4487758875, green: 0.4389013052, blue: 0.9776882529, alpha: 1)
        pageController.pageIndicatorTintColor = UIColor.gray
        pageController.currentPageIndicatorTintColor = #colorLiteral(red: 0.4487758875, green: 0.4389013052, blue: 0.9776882529, alpha: 1)
        self.view.addSubview(pageController)
       
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContent = pageViewController.viewControllers![0]
        self.pageController.currentPage = arrContainer.firstIndex(of: pageContent)!
    }

}
