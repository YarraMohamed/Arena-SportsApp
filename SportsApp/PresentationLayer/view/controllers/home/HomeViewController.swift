//
//  HomeViewController.swift
//  SportsApp
//
//  Created by Yara Mohamed on 11/05/2025.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,
                          UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = Bundle.main.loadNibNamed(CellIdentifiers.header, owner: self, options: nil)?.first as! Header
        header.layer.cornerRadius = 60
        header.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        header.layer.masksToBounds = true
        header.translatesAutoresizingMaskIntoConstraints = false
        header.label.text = L10n.Common.sports_header
        view.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        cell.gameLabel.layer.cornerRadius = 16
        cell.gameLabel.layer.masksToBounds = true
        
        switch indexPath.row{
        case 0 :
            cell.gameImg.image = UIImage(named: AppStrings.GameNames.football)
            cell.gameLabel.text = L10n.Games.FOOTBALL
        case 1 :
            cell.gameImg.image = UIImage(named: AppStrings.GameNames.basketball)
            cell.gameLabel.text = L10n.Games.BASKETBALL
        case 2 :
            cell.gameImg.image = UIImage(named: AppStrings.GameNames.cricket)
            cell.gameLabel.text = L10n.Games.CRICKET
        case 3:
            cell.gameImg.image = UIImage(named: AppStrings.GameNames.tennis)
            cell.gameLabel.text = L10n.Games.TENNIS
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 16, bottom: 50, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIDs.leaguesVC) as! LeaguesViewController
        vc.hidesBottomBarWhenPushed = true
        vc.sportId = indexPath.row + 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
