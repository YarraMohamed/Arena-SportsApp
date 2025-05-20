//
//  FavouritesCell.swift
//  Arena
//
//  Created by Yara Mohamed on 15/05/2025.
//

import UIKit

class FavouritesCell: UITableViewCell {

    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var favImg: UIImageView!
    var delegate : FavoriteCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        starImg.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeFavorite))
        starImg.addGestureRecognizer(tapGesture)
    }

    @objc func removeFavorite() {
        delegate?.didTapFavorite(in: self)
        
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

protocol FavoriteCellDelegate{
    func didTapFavorite(in cell: FavouritesCell)
}
