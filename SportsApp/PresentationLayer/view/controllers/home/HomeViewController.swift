//
//  HomeViewController.swift
//  SportsApp
//
//  Created by Yara Mohamed on 11/05/2025.
//

import UIKit

private let reuseIdentifier = "cell"

class HomeViewController: UIViewController,UICollectionViewDelegate,
                          UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = Bundle.main.loadNibNamed("Header", owner: self, options: nil)?.first as! Header
        header.layer.cornerRadius = 60
        header.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        header.layer.masksToBounds = true
        header.translatesAutoresizingMaskIntoConstraints = false
        header.label.text = "Sports"
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        cell.gameLabel.layer.cornerRadius = 16
        cell.gameLabel.layer.masksToBounds = true
        
        switch indexPath.row{
        case 0 :
            cell.gameImg.image = UIImage(named: "football")
            cell.gameLabel.text = "Football"
        case 1 :
            cell.gameImg.image = UIImage(named: "basketball")
            cell.gameLabel.text = "Basketball"
        case 2 :
            cell.gameImg.image = UIImage(named: "cricket")
            cell.gameLabel.text = "Cricket"
        case 3:
            cell.gameImg.image = UIImage(named: "tennis")
            cell.gameLabel.text = "Tennis"
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "leaguesVC") as! LeaguesViewController
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
