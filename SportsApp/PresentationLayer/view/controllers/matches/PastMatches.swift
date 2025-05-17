//
//  PastMatches.swift
//  Arena
//
//  Created by Yara Mohamed on 15/05/2025.
//

import UIKit

class PastMatches: UICollectionViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var teamTwoImg: UIImageView!
    @IBOutlet weak var teamOneImg: UIImageView!
    
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
    
    
}
