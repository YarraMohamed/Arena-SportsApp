//
//  TableContentViewController.swift
//  BottomSheetDemo
//
//  Created by MacBook on 17/05/2025.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var sections : [String] = ["Top Scorer", "Coach", "Players"]
    @IBOutlet weak var teamsDetailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        teamsDetailsTableView.dataSource = self
        teamsDetailsTableView.delegate = self
    }

}

extension TeamDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
            return 1
        case 1:
            return 1
        default:
            return 11
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamDetailsCell", for: indexPath) as! TeamDetailsCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = .grey
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "      \(sections[section])"
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

