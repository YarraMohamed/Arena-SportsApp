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

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueImageView.layer.cornerRadius = leagueImageView.frame.width / 2
        leagueImageView.clipsToBounds = true
       
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0))
    
    }
    
}

protocol LeagueCellDelegate{
    func didTapFavorite(in cell: LeagueCell)
}
