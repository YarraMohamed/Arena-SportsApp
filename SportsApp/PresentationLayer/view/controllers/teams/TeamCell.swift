//
//  TeamCell.swift
//  SportsApp
//
//  Created by MacBook on 17/05/2025.
//

import UIKit

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var teamImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        teamImageView.layer.cornerRadius = teamImageView.frame.width / 2
        teamImageView.clipsToBounds = true
    }

}
