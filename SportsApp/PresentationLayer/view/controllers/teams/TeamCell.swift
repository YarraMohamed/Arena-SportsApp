//
//  TeamCell.swift
//  SportsApp
//
//  Created by MacBook on 17/05/2025.
//

import UIKit
import ShimmerSwift

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    private var shimmerView : ShimmeringView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        teamImageView.layer.cornerRadius = teamImageView.frame.width / 2
        teamImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopShimmer()
    }
    
    func startShimmeringAll() {
        let shimmerView = ShimmeringView(frame: self.bounds)
        let placeholderView = UIView(frame: self.bounds)
        placeholderView.backgroundColor = #colorLiteral(red: 0.8823530078, green: 0.8823530078, blue: 0.8823530078, alpha: 1)
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
