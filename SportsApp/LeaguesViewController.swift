//
//  ViewController.swift
//  SportsApp
//
//  Created by Yara Mohamed on 11/05/2025.
//

import UIKit

class LeaguesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var searchController : UISearchController?
    let leagues = ["Premier League", "La Liga", "Ligue 1", "Serie A", "World Cup", "Ligue 2"]
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Football Leagues"
        tableView.dataSource = self
        tableView.delegate = self
//        setupSearchController()
        

    }
    
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchBar.placeholder = "Search Leagues"
        self.navigationItem.searchController = searchController
        self.searchController?.hidesNavigationBarDuringPresentation = false
        self.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension LeaguesViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        cell.delegate = self
        cell.leagueTitleLabel.text = leagues[indexPath.row]
        cell.leagueTopTeamLabel.text = "1. Liverpool"
        cell.leagueImageView.image = UIImage(named: "premierLeagueLogo")
        return cell
    }
    
}

extension LeaguesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

extension LeaguesViewController : LeagueCellDelegate{
    func didTapFavorite(in cell: LeagueCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        print("Button tapped at row \(indexPath.row)")
        cell.isFavorite.toggle()
        if(cell.isFavorite){
            print("Added to favorites")
        } else{
            print("Removed from favorites")
        }

    }
}



