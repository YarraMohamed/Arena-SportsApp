//
//  ComingMatches.swift
//  Arena
//
//  Created by Yara Mohamed on 15/05/2025.
//

import UIKit

class ComingMatches: UICollectionViewCell {

    @IBOutlet weak var teamOneImg: UIImageView!
    @IBOutlet weak var teamTwoImg: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        teamOneImg.layer.cornerRadius = teamOneImg.frame.width / 2
        teamOneImg.layer.masksToBounds = true
        
        teamTwoImg.layer.cornerRadius = teamTwoImg.frame.width / 2
        teamOneImg.layer.masksToBounds = true
        
        self.layer.masksToBounds = true
    }

}
