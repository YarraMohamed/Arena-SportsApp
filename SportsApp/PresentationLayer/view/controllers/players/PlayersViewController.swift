//
//  TableContentViewController.swift
//  BottomSheetDemo
//
//  Created by MacBook on 17/05/2025.
//

import UIKit

class PlayersViewController: UIViewController, PlayersProtocol{

    private var players = [Player]()
    private var coach : Player?
    private var isLoadingPlayers = true
    
    var sections : [String] = [NSLocalizedString("COACH_HEADER", comment: ""), NSLocalizedString("PLAYERS_HEADER", comment: "")]
    var presenter = PlayersPresenter(playersUsecase: PlayersUseCase(repo: PlayersRepository(service: PlayersService())))
    var sportId : Int?
    var teamId : Int?
    
    @IBOutlet weak var playersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playersTableView.dataSource = self
        playersTableView.delegate = self
        
        presenter.setTableView(self)
        presenter.getPlayers(map: sportId ?? 1, teamId: teamId ?? 2)
    }
    
    func renderPlayers(result: PlayersResponse?) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoadingPlayers = false
            self?.coach = result?.result?.first
            self?.players = Array(result?.result?.dropFirst() ?? [])
            print("Players count: \(self?.players.count)")
            self?.playersTableView.reloadData()
        }
    }

}

extension PlayersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return isLoadingPlayers ? 0 : coach != nil ? 1 : 0
        default:
            return isLoadingPlayers ? 0 : players.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        if isLoadingPlayers {
            
        } else {
            let placeholder = UIImage(named: "playerPlaceholder")
            switch indexPath.section {
                case 0:
                    if coach != nil{
                        cell.playerName.text = coach?.playerName ?? "N/A"
                        cell.playerType.text = ""
                        cell.playerImgView.kf.setImage(with: URL(string: coach?.playerImage ?? "https://mahoneycommercial.com/wp-content/uploads/2024/06/421-4212617_person-placeholder-image-transparent-hd-png-download.png"), placeholder: placeholder)
                    }
                default:
                    if !players.isEmpty{
                        cell.playerName.text = players[indexPath.row].playerName
                        cell.playerType.text = players[indexPath.row].playerType
                        cell.playerImgView.kf.setImage(with: URL(string: players[indexPath.row].playerImage ?? "https://mahoneycommercial.com/wp-content/uploads/2024/06/421-4212617_person-placeholder-image-transparent-hd-png-download.png"), placeholder: placeholder)
                    }
            }
        }
        
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
        return 120
    }
}

