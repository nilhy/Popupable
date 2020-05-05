//
//  PopupPresentationController.swift
//  Popupable
//
//  Created by nilhy on 05/05/2020.
//  Copyright (c) 2020 nilhy. All rights reserved.
//



import UIKit

final class PopupPresentationController: UIPresentationController {
    
    var coverColor = UIColor(white: 0.1, alpha: 0.5) {
        didSet {
            backgroundView.backgroundColor = coverColor
        }
    }
    
    private lazy var backgroundView = UIView(frame: CGRect.zero)
    
    override func presentationTransitionWillBegin() {
        
        if let containerView = containerView {
            
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            containerView.insertSubview(backgroundView, at: 0)
            containerView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0))
            containerView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0))
            containerView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0))
            containerView.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0))
            excuteBackgroundAnimation()
        }
    }
    
        
    override func dismissalTransitionWillBegin() {
        excuteBackgroundDismissAnimation()
    }
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    private func excuteBackgroundAnimation() {
        backgroundView.alpha = 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (_) in
                self.backgroundView.alpha = 1
            }, completion: nil)
        }
    }
    
    private func excuteBackgroundDismissAnimation() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
}
