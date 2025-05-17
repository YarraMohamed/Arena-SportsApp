//
//  PastMatches.swift
//  Arena
//
//  Created by Yara Mohamed on 15/05/2025.
//

import UIKit
import ShimmerSwift
import Kingfisher


class PastMatches: UICollectionViewCell {

    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var teamTwoImg: UIImageView!
    @IBOutlet weak var teamOneImg: UIImageView!
    
    private let shimmerOne = ShimmeringView()
    private let shimmerTwo = ShimmeringView()
    private var shimmerView : ShimmeringView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        teamOneImg.layer.cornerRadius = teamOneImg.frame.width / 2
        teamOneImg.layer.masksToBounds = true
        
        teamTwoImg.layer.cornerRadius = teamTwoImg.frame.width / 2
        teamTwoImg.layer.masksToBounds = true

        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.2
        self.layer.masksToBounds = true
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopShimmer()
        shimmerOne.removeFromSuperview()
        shimmerTwo.removeFromSuperview()
    }       
    func setTeamImages(homeURL: URL?, awayURL: URL?) {
        shimmerOne.isShimmering = true
        shimmerTwo.isShimmering = true
           
        teamOneImg.kf.setImage(with: homeURL) { [weak self] result in
            self?.shimmerOne.isShimmering = false
            self?.shimmerOne.removeFromSuperview()
        }
           
        teamTwoImg.kf.setImage(with: awayURL) { [weak self] result in
            self?.shimmerTwo.isShimmering = false
            self?.shimmerTwo.removeFromSuperview()
        }
    }
    
    func startShimmeringAll() {
        let shimmerView = ShimmeringView(frame: self.bounds)
        let placeholderView = UIView(frame: self.bounds)
        placeholderView.backgroundColor = #colorLiteral(red: 0.8809021711, green: 0.8809021711, blue: 0.8809021711, alpha: 1)
        placeholderView.layer.cornerRadius = 10
        placeholderView.layer.masksToBounds = true

        shimmerView.contentView = placeholderView
        shimmerView.isShimmering = true

        self.addSubview(shimmerView)
        self.sendSubviewToBack(shimmerView)
        
        self.shimmerView = shimmerView
    }

    func stopShimmer() {
        shimmerView?.isShimmering = false
        shimmerView?.removeFromSuperview()
        shimmerView = nil
    }
}
