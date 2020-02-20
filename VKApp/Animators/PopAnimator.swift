//
//  PopAnimator.swift
//  VKApp
//
//  Created by Сергей Зесли on 10.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from), let destination = transitionContext.viewController(forKey: .to) else {
            return
        }
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)

       // let rot = CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 2)
        //let trans = CGAffineTransform(translationX: -transitionContext.containerView.frame.width / 2, y: -transitionContext.containerView.frame.height / 2)
        source.view.transform = CGAffineTransform(translationX: -transitionContext.containerView.frame.width / 2, y: -transitionContext.containerView.frame.height / 2)
        
        let duration = self.transitionDuration(using: transitionContext)

        
        UIView.animate(withDuration: duration, animations: {
            source.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 2).concatenating(CGAffineTransform(translationX: -transitionContext.containerView.frame.width / 2, y: -transitionContext.containerView.frame.height / 2))
       }) { (finished) in
            if finished &&  !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
                source.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                source.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                source.view.transform = .identity
                
            }
        
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
    
}
