//
//  ShowAnimator.swift
//  Popupable
//
//  Created by nilhy on 05/05/2020.
//  Copyright (c) 2020 nilhy. All rights reserved.
//


import UIKit

public class ShowAnimator : NSObject {
    public var transitionDuration: TimeInterval = 0.35
    public var usingSpringWithDamping: CGFloat = 1
    public var initialSpringVelocity: CGFloat = 2.0
}


extension ShowAnimator {
    static var `default`: ShowAnimator = ShowAnimator()
}

extension ShowAnimator : UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController( forKey: UITransitionContextViewControllerKey.to),
            let toView = transitionContext.view( forKey: UITransitionContextViewKey.to)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        toView.frame = transitionContext.finalFrame(for: toViewController)
        containerView.addSubview(toView)
        
        
        toView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        UIView.animate(withDuration: transitionDuration,
                       delay: 0,
                       usingSpringWithDamping: usingSpringWithDamping,
                       initialSpringVelocity: initialSpringVelocity,
                       options: .curveEaseInOut, animations: {
                                toView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }

    }
}
