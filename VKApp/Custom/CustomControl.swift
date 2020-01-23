//
//  CustomControl.swift
//  VKApp
//
//  Created by Сергей Зесли on 24.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

@IBDesignable class CustomControl: UIControl {
    private var lab: UILabel!
    private var imageView: UIImageView!
    private var stackView: UIStackView!
    @IBInspectable var likes: Int = 0 {
        didSet {
            if likes == 0 {
                lab.textColor = .black
            } else {
                lab.textColor = .red
            }
            lab.text = "\(likes)"
            analizeLikes()
        }
    }
    
    @IBInspectable var imgLike: UIImage! {
        didSet {
            analizeLikes()
        }
    }

    @IBInspectable var imgNoLike: UIImage! {
        didSet {
            analizeLikes()
        }
    }
    
    private func analizeLikes() {
        if likes == 0 {
            imageView.image = imgNoLike
        } else {
            imageView.image = imgLike
        }

    }


    private func setupView(){
        lab = UILabel()
        lab.textColor = .black
        lab.font = .boldSystemFont(ofSize: 16)
        lab.text = "0"
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        
        stackView = UIStackView(arrangedSubviews: [lab,imageView])
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.alignment = .bottom
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        backgroundColor = .clear

        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        likes = (likes == 0) ? 1 : 0
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        print("eewwew")
        return true
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
