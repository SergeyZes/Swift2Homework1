//
//  GroupTableViewCell.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImage: UIImageView!
    
    @IBOutlet weak var groupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        groupImage.addGestureRecognizer(tapGesture)
        groupImage.isUserInteractionEnabled = true
        
        // Initialization code
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
         let animation = CASpringAnimation(keyPath: "transform.scale")
         
         animation.fromValue = 0
         animation.toValue = 1
         animation.stiffness = 200
         animation.mass = 2
         animation.duration = 2
         print("annn")
         
         groupImage.layer.add(animation, forKey: nil)
        

      }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
