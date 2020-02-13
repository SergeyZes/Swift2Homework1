//
//  PushAnimator.swift
//  VKApp
//
//  Created by Сергей Зесли on 10.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 1
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from), let destination = transitionContext.viewController(forKey: .to) else {
            return
        }
        transitionContext.containerView.addSubview(destination.view)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)

        let rot = CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 2)
        let trans = CGAffineTransform(translationX: -transitionContext.containerView.frame.width / 2, y: -transitionContext.containerView.frame.height / 2)
        
        
        destination.view.transform = rot.concatenating(trans)
        
        UIView.animate(withDuration: animationDuration, animations: {
            destination.view.transform = trans
        }) { (finished) in
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            destination.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            destination.view.transform = .identity
        }
        
    }
    
    
}
