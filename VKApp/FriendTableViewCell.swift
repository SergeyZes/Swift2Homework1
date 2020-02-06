//
//  FriendTableViewCell.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarImage: CustomView!
    
    @IBOutlet weak var friendLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func animate() {
        avatarImage.transform = CGAffineTransform(translationX: -100, y: 0).scaledBy(x: 0.1, y: 0.1).rotated(by: 10)
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.avatarImage.transform = .identity
            self.avatarImage.imageView.alpha = 1
        }, completion: nil)
    }

}
