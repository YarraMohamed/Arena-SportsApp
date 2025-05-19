//
//  MatchesCollectionViewController.swift
//  Arena
//
//  Created by Yara Mohamed on 15/05/2025.
//

import UIKit
import Kingfisher
import ShimmerSwift

private let comingMatchesReuseIdentifier = "comingMatches"
private let pastMatchesReuseIdentifier = "pastMatches"
private let teamsReuseIdentifier = "teams"


class MatchesCollectionViewController: UICollectionViewController,
                                       UICollectionViewDelegateFlowLayout, MatchesProtocol, TeamsProtocol, PlayersProtocol{
    
    private var comingMatches = [Fixtures]()
    private var pastMatches = [Fixtures]()
    private var teams = [Team]()
    private var players = [Player]()
    private var isLoadingComingMatches = true
    private var isLoadingPastMatches = true
    private var isLoadingTeams = true
    private var isLoadingPlayers = true
    

    
    var selectedLeagueTitle : String?
    var sportId : Int?
    var leagueId : Int?
    
    private var sectionTitles: [String] {
        return [
            "Upcoming Matches",
            "Past Matches",
            (sportId == 4 ? "Players" : "Teams")
        ]
    }
    var presenter = MatchesPresenter(fixturesUsecase: FetchFixtures(repo: FixturesRepository(service: FixturesService())))
    
    var teamsPresenter = TeamsPresenter(teamsUsecase: TeamsUseCase(repo: TeamsRepository(service: TeamsService())))
    var playersPresenter = PlayersPresenter(playersUsecase: PlayersUseCase(repo: PlayersRepository(service: PlayersService())))
   
    override func viewDidLoad() {
        super.viewDidLoad()
  
        collectionView.register(UINib(nibName: "ComingMatches", bundle: nil), forCellWithReuseIdentifier: comingMatchesReuseIdentifier)
        collectionView.register(UINib(nibName: "PastMatches", bundle: nil), forCellWithReuseIdentifier: pastMatchesReuseIdentifier)
        collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: teamsReuseIdentifier)
        
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseIdentifier)
        
        self.navigationItem.title = selectedLeagueTitle ?? ""
        
        presenter.setTableView(self)
        teamsPresenter.setTableView(self)
        playersPresenter.setTableView(self)
        
        presenter.getUpcomingMatches(map: sportId ?? 1, from: currentDateFormatter(), to: futureDateFormatter(),leagueId:    String(describing: leagueId ?? 0))
        presenter.getPastMatches(map:sportId ?? 1, from: pastYearDataFormatter(), to: pastDateFormatter(), leagueId:    String(describing: leagueId ?? 0))
        
        teamsPresenter.getTeams(map: sportId ?? 1, leagueId: leagueId ?? 204)
        
        playersPresenter.getTennisPlayers(map: sportId ?? 1, leagueId: leagueId ?? 2)
    
        setupLayout()
    }
    
    
    func renderUpcomingMatches(result: FixturesResponse?) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoadingComingMatches = false
            self?.comingMatches = result?.result ?? []
            self?.collectionView.reloadData()
        }
    }
    
    func renderPastMatches(result: FixturesResponse?) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoadingPastMatches = false
            self?.pastMatches = result?.result ?? []
            self?.collectionView.reloadData()
        }
    }
    
    func renderTeams(result: TeamsResponse?) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoadingTeams = false
            self?.teams = result?.result ?? []
            self?.collectionView.reloadData()
        }
    }
    
    func renderPlayers(result: PlayersResponse?) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoadingPlayers = false
            self?.players = result?.result ?? []
            self?.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            if(isLoadingComingMatches || comingMatches.isEmpty){
                return 1
            }
            return comingMatches.count
        case 1:
            if(isLoadingPastMatches || pastMatches.isEmpty){
                return 1
            }

            return isLoadingPastMatches ? 1 :  pastMatches.count
            
        default :
            switch sportId{
            case 4:
                if(isLoadingPlayers || players.isEmpty){
                    return 1
                }
                return isLoadingPlayers ? 1 : players.count
                
                default :
                    return isLoadingTeams ? 1 : teams.count
            }
            
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: comingMatchesReuseIdentifier, for: indexPath) as! ComingMatches
            if isLoadingComingMatches {
                cell.startShimmeringAll()
                cell.vsLabel.text = ""
            }else if comingMatches.isEmpty{
                cell.startShimmeringAll()
                cell.emptyLabel.text = "No Upcoming Matches"
            }else{
                cell.stopShimmer()
                cell.vsLabel.text = "VS"
                cell.date.text = comingMatches[indexPath.row].date
                cell.time.text = comingMatches[indexPath.row].time
                cell.teamOneName.text = comingMatches[indexPath.row].opponentOne
                cell.teamTwoName.text = comingMatches[indexPath.row].opponentTwo
                let homeLogoURL = URL(string: comingMatches[indexPath.row].opponentOneLogo)
                let awayLogoURL = URL(string: comingMatches[indexPath.row].opponentTwoLogo)
                cell.setTeamImages(homeURL: homeLogoURL, awayURL: awayLogoURL)
            }
            return cell
            
        case 1 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pastMatchesReuseIdentifier, for: indexPath) as! PastMatches
            if isLoadingPastMatches {
                cell.startShimmeringAll()
                cell.date.text = ""
                cell.time.text = ""
                cell.score.text = ""
                cell.vsLabel.text = ""
            }else if pastMatches.isEmpty{
                cell.startShimmeringAll()
                cell.emptyLabel.text = "No Past Matches"
                
            }else{
                cell.stopShimmer()
                cell.vsLabel.text = "VS"
                cell.date.text = pastMatches[indexPath.row].date
                cell.time.text = pastMatches[indexPath.row].time
                cell.score.text = pastMatches[indexPath.row].score
                cell.teamOneName.text = pastMatches[indexPath.row].opponentOne
                cell.teamTwoName.text = pastMatches[indexPath.row].opponentTwo
                let homeLogoURL = URL(string: pastMatches[indexPath.row].opponentOneLogo)
                let awayLogoURL = URL(string: pastMatches[indexPath.row].opponentTwoLogo)
                cell.setTeamImages(homeURL: homeLogoURL, awayURL: awayLogoURL)
            }
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamsReuseIdentifier, for: indexPath) as! TeamCell
            
            switch sportId{
            case 4:
                if isLoadingPlayers{
                    // cell.startShimmeringAll()
                    // cell.vsLabel.text = ""

                }else{
    //              cell.stopShimmer()
                    cell.teamImageView.kf.setImage(with: URL(string: players[indexPath.row].playerImage ?? "https://static.becharge.be/img/be/placeholder.png"), placeholder: UIImage(named: "leaguePlaceholder"))
                    
                    cell.teamName.text = players[indexPath.row].playerName
                }
                
                default :
                if isLoadingTeams {
        //                cell.startShimmeringAll()
        //                cell.vsLabel.text = ""
                    }else{
        //                cell.stopShimmer()
                        cell.teamImageView.kf.setImage(with: URL(string: teams[indexPath.row].teamLogo ?? "https://static.becharge.be/img/be/placeholder.png"), placeholder: UIImage(named: "leaguePlaceholder"))
                        
                        cell.teamName.text = teams[indexPath.row].teamName
                    }
            }
            
            return cell
        }

    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                              withReuseIdentifier: SectionHeader.reuseIdentifier,
                                                                              for: indexPath) as! SectionHeader
            headerView.label.text = sectionTitles[indexPath.section]
            return headerView
        }

        return UICollectionReusableView()
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sport = sportId, (1...3).contains(sport) {
            switch indexPath.section{
            case 0:
                print("Coming matches")
            case 1:
                print("Past matches")
            default:
                let vc = CustomModalViewController()
                vc.modalPresentationStyle = .overCurrentContext
                vc.sportId = sportId
                vc.teamId = teams[indexPath.row].teamKey
                vc.teamLogo = teams[indexPath.row].teamLogo
                vc.teamName = teams[indexPath.row].teamName
                
                self.present(vc, animated: false)
            }
        }
    }


    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension MatchesCollectionViewController {
    
    private func drawComingMatchesSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
        let myGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        myGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: myGroup)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 20, bottom: 10, trailing: 10)
    
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(10))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: -5, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [header]

        
        return section
    }
}

extension MatchesCollectionViewController {
    
    private func drawPastMatchesSection()-> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170))
        let myGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        myGroup.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let section = NSCollectionLayoutSection(group: myGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
           
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(10))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
       }
    
}

extension MatchesCollectionViewController{
    private func drawTeamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(80),
            heightDimension: .absolute(100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(100)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(30)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(10))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        // animation
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items
                .filter { $0.representedElementKind == nil}
                .forEach { item in
                    let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                    let minScale: CGFloat = 0.8
                    let maxScale: CGFloat = 1.0
                    let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                    item.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            
        }
        
        return section
    }
}


extension MatchesCollectionViewController {
    
    private func setupLayout(){
        
        let layout = UICollectionViewCompositionalLayout{index ,environement in
            switch index{
            case 0 :
                return self.drawComingMatchesSection()
            case 1:
                return self.drawPastMatchesSection()
            default:
                return self.drawTeamsSection()
            }
        }
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
}
