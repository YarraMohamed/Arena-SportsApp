//
//  LeagueCell.swift
//  SportsApp
//
//  Created by MacBook on 11/05/2025.
//

import UIKit
import ShimmerSwift

class LeagueCell: UITableViewCell {

    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var leagueTopTeamLabel: UILabel!
    @IBOutlet weak var leagueTitleLabel: UILabel!
    @IBOutlet weak var leagueImageView: UIImageView!
    private var shimmerView : ShimmeringView?
    var delegate : LeagueCellDelegate?
    var isFavorite : Bool = false {
        didSet {
            starImageView.image = isFavorite ? UIImage(named: "filledStar") : UIImage(named: "star")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        starImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addLeagueToFavorite))
        starImageView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func addLeagueToFavorite() {
        delegate?.didTapFavorite(in: self)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopShimmer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImageView.layer.cornerRadius = leagueImageView.frame.width / 2
        leagueImageView.clipsToBounds = true
       
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0))
    
    }
    
    func startShimmeringAll() {
        let shimmerView = ShimmeringView(frame: contentView.bounds)
        shimmerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Create a placeholder copy of contentView if needed
        let placeholderView = UIView(frame: contentView.bounds)
        placeholderView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        placeholderView.layer.cornerRadius = 10
        placeholderView.layer.masksToBounds = true

        shimmerView.contentView = placeholderView
        shimmerView.isShimmering = true

        contentView.addSubview(shimmerView)
        contentView.sendSubviewToBack(shimmerView)

        self.shimmerView = shimmerView
    }


    func stopShimmer() {
        shimmerView?.isShimmering = false
        shimmerView?.removeFromSuperview()
        shimmerView = nil
    }
    
}

protocol LeagueCellDelegate{
    func didTapFavorite(in cell: LeagueCell)
}
