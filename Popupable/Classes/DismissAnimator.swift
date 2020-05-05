//
//  DismissAnimator.swift
//  Popupable
//
//  Created by nilhy on 05/05/2020.
//  Copyright (c) 2020 nilhy. All rights reserved.
//

import UIKit

public class DismissAnimator : NSObject {
    public var transitionDuration: TimeInterval = 0.35
}


extension DismissAnimator {
    static var `default`: DismissAnimator = DismissAnimator()
}

extension DismissAnimator : UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        if fromVC.modalPresentationStyle == .fullScreen  {
            transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        }
        
        let screenBounds = UIScreen.main.bounds
        let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
        let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.frame = finalFrame
        }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
