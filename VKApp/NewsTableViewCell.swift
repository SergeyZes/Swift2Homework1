//
//  NewsTableViewCell.swift
//  VKApp
//
//  Created by Сергей Зесли on 02.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: CustomView!
    
    @IBOutlet weak var friendLabel: UILabel!
    
    @IBOutlet weak var newDate: UILabel!
    @IBOutlet weak var newText: UILabel!
    
    @IBOutlet weak var newViews: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
