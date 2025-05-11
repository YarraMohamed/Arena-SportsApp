//
//  ViewController.swift
//  SportsApp
//
//  Created by MacBook on 11/05/2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func navigate(_ sender: Any) {
        let leaguesVC = self.storyboard?.instantiateViewController(withIdentifier: "leaguesVC") as! LeaguesViewController
        
        self.navigationController?.pushViewController(leaguesVC, animated: true)
    }

}
