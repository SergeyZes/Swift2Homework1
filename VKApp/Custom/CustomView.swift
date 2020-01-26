//
//  CustomView.swift
//  VKApp
//
//  Created by Сергей Зесли on 24.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {
    
    @IBInspectable var img: UIImage! {
        didSet {
            imageView.image = img
            setupConstraints(constr: constrShift)
             //backgroundColor = .clear
        }
    }
    
    @IBInspectable var constrShift: CGFloat = 0 {
        didSet {
            setupConstraints(constr: constrShift)
        }
    }
    
    @IBInspectable var shadOpacity: Float = 1 {
        didSet {
            setupShadow()
        }
    }

    @IBInspectable var shadRadius: CGFloat = 10 {
        didSet {
            setupShadow()
        }
    }

    
    @IBInspectable var shadColor: UIColor = UIColor.black {
        didSet {
            setupShadow()
        }
    }

    
    private var imageView: UIImageView
    private var view1: UIView
    
    override init(frame: CGRect) {
        view1 = UIView()
        view1.backgroundColor = .black
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        super.init(frame: frame)
        addSubview(view1)
        addSubview(imageView)
        setupConstraints(constr: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints(constr: constrShift)
    }
    
    required init?(coder: NSCoder) {
        view1 = UIView()
        view1.backgroundColor = .black
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        super.init(coder: coder)
        addSubview(view1)
        addSubview(imageView)
         setupConstraints(constr: 0)

    }
    
    
    
    private func setupShadow(){
        view1.layer.shadowColor = shadColor.cgColor
        view1.layer.shadowOpacity = shadOpacity
        view1.layer.shadowRadius = shadRadius

    }
      

    private func setupConstraints(constr: CGFloat){
        
        
        var size = bounds.width - 2 * constr
        
        if (bounds.height - 2 * constr) < size {
            size = bounds.height - 2 * constr
        }
        
        view1.frame = CGRect(x: ((bounds.width - size) / 2), y: ((bounds.height - size) / 2), width: size, height: size)
        imageView.frame = CGRect(x: ((bounds.width - size) / 2), y: ((bounds.height - size) / 2), width: size, height: size)

        
        view1.layer.cornerRadius = size / 2
        imageView.layer.cornerRadius = size / 2
        imageView.layer.masksToBounds = true
        
        view1.layer.shadowOffset = CGSize(width: 3, height: 3)
        view1.layer.cornerRadius = size/2
        setupShadow()
        
        
        
        //imageView.addConstraints([topC,botC,leftC,rightC])
        
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
