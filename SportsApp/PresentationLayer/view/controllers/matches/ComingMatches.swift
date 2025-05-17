//
//  ComingMatches.swift
//  Arena
//
//  Created by Yara Mohamed on 15/05/2025.
//

import UIKit
import ShimmerSwift
import Kingfisher

class ComingMatches: UICollectionViewCell {

    @IBOutlet weak var teamOneImg: UIImageView!
    @IBOutlet weak var teamTwoImg: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    
    private let shimmerOne = ShimmeringView()
    private let shimmerTwo = ShimmeringView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShimmer()
    }
    
    override func layoutSubviews() {
        teamOneImg.layer.cornerRadius = 10
        teamOneImg.layer.masksToBounds = true
        
        teamTwoImg.layer.cornerRadius = 10
        teamOneImg.layer.masksToBounds = true
        
        self.layer.masksToBounds = true
    }

    private func setupShimmer() {
           shimmerOne.frame = teamOneImg.bounds
           shimmerOne.contentView = UIImageView(image: UIImage(named: "grey"))
           teamOneImg.addSubview(shimmerOne)
           
           shimmerTwo.frame = teamTwoImg.bounds
           shimmerTwo.contentView = UIImageView(image: UIImage(named: "grey"))
           teamTwoImg.addSubview(shimmerTwo)
       }
       
       func setTeamImages(homeURL: URL?, awayURL: URL?) {
           shimmerOne.isShimmering = true
           shimmerTwo.isShimmering = true
           
           teamOneImg.kf.setImage(with: homeURL, placeholder: nil, options: nil, progressBlock: nil) { [weak self] result in
               self?.shimmerOne.isShimmering = false
               self?.shimmerOne.removeFromSuperview()
           }
           
           teamTwoImg.kf.setImage(with: awayURL, placeholder: nil, options: nil, progressBlock: nil) { [weak self] result in
               self?.shimmerTwo.isShimmering = false
               self?.shimmerTwo.removeFromSuperview()
           }
       }
}
