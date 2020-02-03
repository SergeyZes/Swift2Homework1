//
//  CustomPoints3.swift
//  VKApp
//
//  Created by Сергей Зесли on 03.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

@IBDesignable
class CustomPoints3: UIView {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var item1: UIView!
    @IBOutlet weak var item2: UIView!
    @IBOutlet weak var item3: UIView!
    
    weak var vi: UIView!
    

    
    @IBInspectable
    var spacing: CGFloat = 0 {
        didSet {
            stackView.spacing = spacing
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        vi = loadViewFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        vi = loadViewFromNib()
    }
    
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "CustomPoints3", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
      //  setRound()
        return view
        
    }
    
    


}
