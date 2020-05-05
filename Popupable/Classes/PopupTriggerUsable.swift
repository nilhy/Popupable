//
//  PopupTriggerUsable.swift
//  Popupable
//
//  Created by nilhy on 05/05/2020.
//  Copyright (c) 2020 nilhy. All rights reserved.
//


import UIKit

public typealias PopupTriggerViewController = (UIViewController & PopupTriggerUsable )

public protocol PopupTriggerUsable {
    var dismissInteractor: DismissInteractor { get }
    var dismissAnimator: DismissAnimator { get }
    var showAnimator: ShowAnimator { get }
}

public extension PopupTriggerUsable {
    var dismissInteractor: DismissInteractor { return DismissInteractor.default }
    var dismissAnimator: DismissAnimator { return DismissAnimator.default }
    var showAnimator: ShowAnimator { return ShowAnimator.default }
}



final class PopupTriggerTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private weak var rootViewController: PopupTriggerViewController?

    init(rootViewController: PopupTriggerViewController) {
        super.init()
        self.rootViewController = rootViewController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return rootViewController?.dismissAnimator
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return rootViewController?.showAnimator
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller =  PopupPresentationController(presentedViewController: presented, presenting: presenting)
        
        controller.coverColor = UIColor.black.withAlphaComponent(0.7)
        return controller

    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let dismissInteractor = rootViewController?.dismissInteractor else { return nil }
        return dismissInteractor.hasStarted ? dismissInteractor : nil
    }

}
