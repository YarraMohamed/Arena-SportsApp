//
//  FavouritesCell.swift
//  Arena
//
//  Created by Yara Mohamed on 15/05/2025.
//

import UIKit

class FavouritesCell: UITableViewCell {

    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var favImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        favImg.layer.cornerRadius = 40
        favImg.clipsToBounds = true
    }

}
