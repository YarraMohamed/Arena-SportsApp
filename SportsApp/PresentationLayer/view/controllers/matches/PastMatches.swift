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
        
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.4487758875, green: 0.4389013052, blue: 0.9776882529, alpha: 1)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    
    }
    
    
}
