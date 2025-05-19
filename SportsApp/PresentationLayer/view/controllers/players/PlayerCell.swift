//
//  TeamDetailsCell.swift
//  SportsApp
//
//  Created by MacBook on 17/05/2025.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerImgView.layer.cornerRadius = playerImgView.frame.width / 2
        playerImgView.clipsToBounds = true
       
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    
    }

}
