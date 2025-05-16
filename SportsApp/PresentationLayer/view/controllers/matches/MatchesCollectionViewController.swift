//
//  MatchesCollectionViewController.swift
//  Arena
//
//  Created by Yara Mohamed on 15/05/2025.
//

import UIKit

private let comingMatchesReuseIdentifier = "coming"
private let pastMatchesReuseIdentifier = "pastMatches"


class MatchesCollectionViewController: UICollectionViewController,
                                       UICollectionViewDelegateFlowLayout{
    
    private let sectionTitles = ["Upcoming Matches", "Past Matches", "Teams"]
    var selectedLeagueTitle : String?
    var presenter = MatchesPresenter(fixturesUsecase: FetchFixtures(repo: FixturesRepository(service: FixturesService())))
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ComingMatches", bundle: nil), forCellWithReuseIdentifier: comingMatchesReuseIdentifier)
        collectionView.register(UINib(nibName: "PastMatches", bundle: nil), forCellWithReuseIdentifier: pastMatchesReuseIdentifier)
        
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseIdentifier)
        
        self.navigationItem.title = selectedLeagueTitle ?? ""
        
        presenter.setTableView(self)
        presenter.getData()
        
        setupLayout()
    }
    
    func renderView(result:FixturesResponse?){
        print("\(result?.result.count)")
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 2
        default :
            return 3
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell!
        
        switch indexPath.section {
        case 0 :
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: comingMatchesReuseIdentifier, for: indexPath) as! ComingMatches
            
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pastMatchesReuseIdentifier, for: indexPath) as! PastMatches
        }

        return cell
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

extension MatchesCollectionViewController {
    
    private func setupLayout(){
        
        let layout = UICollectionViewCompositionalLayout{index ,environement in
            switch index{
            case 0 :
                return self.drawComingMatchesSection()
            default:
                return self.drawPastMatchesSection()
            }
        }
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
}
