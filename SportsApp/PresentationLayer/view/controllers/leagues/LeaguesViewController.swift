//
//  ViewController.swift
//  SportsApp
//
//  Created by Yara Mohamed on 11/05/2025.
//

import UIKit

class LeaguesViewController: UIViewController, FavouritesProtocol{

    @IBOutlet weak var tableView: UITableView!
    var sportId : Int?
    private var searchController : UISearchController?
    private var favoriteLeagues = [Favourites]()
    private var leagues  = [League]()
    private var presenter = LeaguesPresenter(leaguesUseCase: LeaguesUseCase(repo: LeaguesRepository(service: LeaguesService())))
    
    private var favPresenter = FavouritesPresenter(useCase: FavouritesUsecase(repo: FavouritesRepository(service: FavouriteService.shared)))
    private var isLoadingLeagues = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Leagues"
        tableView.dataSource = self
        tableView.delegate = self
//        setupSearchController()
        
        presenter.setTableView(self)
        presenter.getLeagues(map: sportId ?? 1)
        favPresenter.setTableView(self)
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favPresenter.getFavs()
    }
    
    func renderFavourites(result: [Favourites]?) {
        if let favorites = result {
            self.favoriteLeagues = favorites
            self.tableView.reloadData()
        }
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

extension LeaguesViewController : LeaguesProtocol{
    func renderLeagues(result: LeaguesResponse?) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoadingLeagues = false
            self?.leagues = result?.result ?? []
            self?.tableView.reloadData()
        }
    }
}

extension LeaguesViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isLoadingLeagues || leagues.isEmpty){
            return 1
        }
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        if isLoadingLeagues {
            cell.startShimmeringAll()
            cell.leagueTitleLabel.text = ""
            cell.leagueTopTeamLabel.text = ""
        }else{
            cell.stopShimmer()
            cell.delegate = self
            cell.leagueTitleLabel.text = leagues[indexPath.row].leagueName
            cell.leagueTopTeamLabel.text = leagues[indexPath.row].countryName
            cell.leagueImageView.kf.setImage(with: URL(string: leagues[indexPath.row].leagueLogo ?? "https://static.becharge.be/img/be/placeholder.png"), placeholder: UIImage(named: "leaguePlaceholder"))
            
            let league = leagues[indexPath.row]
            let isFavorite = favoriteLeagues.contains {
                $0.id == league.leagueKey && $0.map == sportId
            }
            cell.isFavorite = isFavorite
        }
        return cell
    }
    
}

extension LeaguesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "matchesScreen") as! MatchesCollectionViewController
        vc.selectedLeagueTitle = leagues[indexPath.row].leagueName
        vc.sportId = sportId
        vc.leagueId = leagues[indexPath.row].leagueKey
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LeaguesViewController : LeagueCellDelegate{
    func didTapFavorite(in cell: LeagueCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let league = leagues[indexPath.row]
        print("Button tapped at row \(indexPath.row)")
        cell.isFavorite.toggle()
        if(cell.isFavorite){
            print("Added to favorites")
            let favorite = Favourites(map: sportId ?? 1, id: league.leagueKey, title: league.leagueName, img: league.leagueLogo ?? "")
            favPresenter.saveFav(favorite: favorite)
            favoriteLeagues.append(favorite)
            
        } else{
            print("Removed from favorites")
            favPresenter.deleteFav(id: league.leagueKey)
            favoriteLeagues.removeAll { $0.id == league.leagueKey }
        }

    }
}



