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
                                       UICollectionViewDelegateFlowLayout, MatchesProtocol{
    
    private let sectionTitles = ["Upcoming Matches", "Past Matches", "Teams"]
    private var comingMatches = [Fixtures]()
    private var pastMatches = [Fixtures]()
    private var isLoadingComingMatches = true
    private var isLoadingPastMatches = true

    
    var selectedLeagueTitle : String?
    var sportId : Int?
    var leagueId : String?
    var presenter = MatchesPresenter(fixturesUsecase: FetchFixtures(repo: FixturesRepository(service: FixturesService())))
   
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
        
        presenter.getUpcomingMatches(map: sportId ?? 1, from: currentDateFormatter(), to: futureDateFormatter(),leagueId: leagueId ?? "")
        presenter.getPastMatches(map:1, from: pastYearDataFormatter(), to: pastDateFormatter(), leagueId: leagueId ?? "")
        
        setupLayout()
    }
    
    
    func renderUpcomingMatches(result: FixturesResponse?) {
        DispatchQueue.main.async {
            self.isLoadingComingMatches = false
            self.comingMatches = result?.result ?? []
            self.collectionView.reloadData()
        }
    }
    
    func renderPastMatches(result: FixturesResponse?) {
        DispatchQueue.main.async {
            self.isLoadingPastMatches = false
            self.pastMatches = result?.result ?? []
            self.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return isLoadingComingMatches ? 1 : comingMatches.count
        case 1:
            return isLoadingPastMatches ? 1 :  pastMatches.count
        default :
            return 4
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: comingMatchesReuseIdentifier, for: indexPath) as! ComingMatches
            if isLoadingComingMatches {
                cell.startShimmeringAll()
                cell.vsLabel.text = ""
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
        switch indexPath.section{
            case 0:
                print("Coming matches")
            case 1:
                print("Past matches")
            default:
                let vc = CustomModalViewController()
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: false)
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)
    
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
            heightDimension: .absolute(80)
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
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
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
