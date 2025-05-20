//
//  FavouritesViewController.swift
//  Arena
//
//  Created by Yara Mohamed on 15/05/2025.
//

import UIKit
import Reachability
import Kingfisher

class FavouritesViewController: UIViewController, FavouritesProtocol {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter = FavouritesPresenter(useCase: FavouritesUsecase(repo: FavouritesRepository(service: FavouriteService.shared)))
    
    var favs = [Favourites]()
    var sections = [FavouriteSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = Bundle.main.loadNibNamed("Header", owner: self, options: nil)?.first as! Header
        header.layer.cornerRadius = 60
        header.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        header.layer.masksToBounds = true
        header.translatesAutoresizingMaskIntoConstraints = false
        header.label.text = "Favourites"
        view.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 150)
        ])
    
        
        presenter.setTableView(self)
        presenter.getFavs()
    }
    
    func renderFavourites(result: [Favourites]?) {
        DispatchQueue.main.async {
            self.favs = result ?? []
            if self.favs.count == 0 {
                self.tableView.isHidden = true
                self.img.isHidden = false
            }else{
                self.tableView.isHidden = false
                self.img.isHidden = true
                self.separatefavs(favs: self.favs)
                self.tableView.reloadData()
            }
        }
    }
}

extension FavouritesViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouritesCell
        cell.delegate = self
        let item = sections[indexPath.section].items[indexPath.row]
        cell.favLabel.text = item.title
            cell.favImg.kf.setImage(with: URL(string: item.img), placeholder: UIImage(named: "leaguePlaceholder"))
        return cell
    }
    
}

extension FavouritesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reachability = try! Reachability()

        if reachability.connection != .unavailable {
            let matchesVC = self.storyboard?.instantiateViewController(identifier: "matchesScreen") as! MatchesCollectionViewController
            matchesVC.sportId = sections[indexPath.section].items[indexPath.row].map
            matchesVC.leagueId = sections[indexPath.section].items[indexPath.row].id
            matchesVC.selectedLeagueTitle = sections[indexPath.section].items[indexPath.row].title
            matchesVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(matchesVC, animated: true)
        } else {
            let alert = UIAlertController(title: "No Internet Connection", message: "Please enable Wi-Fi or mobile data to proceed.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (_) in
                guard let self = self else { return }
                
                let itemToDelete = self.sections[indexPath.section].items[indexPath.row]
                
                if let index = self.favs.firstIndex(where: { $0.id == itemToDelete.id }) {
                    self.favs.remove(at: index)
                }
                
                self.sections[indexPath.section].items.remove(at: indexPath.row)
                
                
                if self.sections[indexPath.section].items.isEmpty {
                    self.sections.remove(at: indexPath.section)
                    tableView.beginUpdates()
                    tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
                    tableView.endUpdates()
                } else {
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.endUpdates()
                }
                
                self.presenter.deleteFav(id: itemToDelete.id)
                
                if self.favs.isEmpty {
                    self.tableView.isHidden = true
                    self.img.isHidden = false
                }
                
                self.tableView.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
 
        }
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

}

extension FavouritesViewController  {
    func separatefavs(favs: [Favourites]) {
        sections.removeAll()
        
        let football = favs.filter { $0.map == 1 }
        let basketball = favs.filter { $0.map == 2 }
        let cricket = favs.filter { $0.map == 3 }
        let tennis = favs.filter { ![1, 2, 3].contains($0.map) }

        if !football.isEmpty {
            sections.append(FavouriteSection(title: "Football", items: football))
        }
        if !basketball.isEmpty {
            sections.append(FavouriteSection(title: "Basketball", items: basketball))
        }
        if !cricket.isEmpty {
            sections.append(FavouriteSection(title: "Cricket", items: cricket))
        }
        if !tennis.isEmpty {
            sections.append(FavouriteSection(title: "Tennis", items: tennis))
        }
    }
}

extension FavouritesViewController: FavoriteCellDelegate {
    func didTapFavorite(in cell: FavouritesCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let favorite = favs[indexPath.row]
        print("Button tapped at row \(indexPath.row)")
        print("Removed from favorites")
        presenter.deleteFav(id: favorite.id)
        favs.removeAll { $0.id == favorite.id }
        }
}
