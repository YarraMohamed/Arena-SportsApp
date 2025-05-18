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

    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var teamOneImg: UIImageView!
    @IBOutlet weak var teamTwoImg: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var teamTwoName: UILabel!
    @IBOutlet weak var teamOneName: UILabel!
    @IBOutlet weak var emptyLabel: UILabel!
    
    private let shimmerOne = ShimmeringView()
    private let shimmerTwo = ShimmeringView()
    private var shimmerView : ShimmeringView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        teamOneImg.layer.cornerRadius = 10
        teamOneImg.layer.masksToBounds = true
        
        teamTwoImg.layer.cornerRadius = 10
        teamTwoImg.layer.masksToBounds = true
        
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
           
        teamOneImg.kf.setImage(with: homeURL, placeholder: UIImage(named: "award"), options: nil, progressBlock: nil) { [weak self] result in
            self?.shimmerOne.isShimmering = false
            self?.shimmerOne.removeFromSuperview()
        }
           
        teamTwoImg.kf.setImage(with: awayURL, placeholder: UIImage(named: "award"), options: nil, progressBlock: nil) { [weak self] result in
            self?.shimmerTwo.isShimmering = false
            self?.shimmerTwo.removeFromSuperview()
        }
    }
    
    func startShimmeringAll() {
        let shimmerView = ShimmeringView(frame: self.bounds)
        let placeholderView = UIView(frame: self.bounds)
        placeholderView.backgroundColor = .lightGray
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
