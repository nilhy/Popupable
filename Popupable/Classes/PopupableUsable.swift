//
//  PopupableUsable.swift
//  Popupable
//
//  Created by nilhy on 05/05/2020.
//  Copyright (c) 2020 nilhy. All rights reserved.
//


import UIKit

public typealias PopupableViewController = (UIViewController & PopupableUsable)

public protocol PopupableUsable {
    var percentThreshold: CGFloat { get }
}

public extension PopupableUsable {
    var percentThreshold: CGFloat { return 0.3 }
}

public extension PopupableUsable where Self: UIViewController {
    
    func setup(_ dismissableVC: PopupTriggerViewController) {
        let dismissTriggerTransitioning = PopupTriggerTransitioningDelegate(rootViewController: dismissableVC)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = dismissTriggerTransitioning
        self.dismissableTriggerTransitioning = dismissTriggerTransitioning
        self.dismissableInteractor = dismissableVC.dismissInteractor
        self.eventDispatcher = PopupableUsableEventDispatcher(rootViewController: self)
    }
}

final class PopupableUsableEventDispatcher: NSObject {
    
    private weak var rootViewController: PopupableViewController?
    private lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(onPanGesture(_:)))
        gesture.delegate = self
        return gesture
    }()

    init(rootViewController: PopupableViewController) {
        super.init()
        
        self.rootViewController = rootViewController
        rootViewController.view.addGestureRecognizer(self.panGesture)
    }
    
    @objc func onPanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let rootViewController = rootViewController else { return }
        guard let interactor = rootViewController.dismissableInteractor else { return }
        
        switch gesture.state {
        case .began:
            interactor.hasStarted = true
            rootViewController.dismiss(animated: true, completion: nil)
        case .changed:
            let verticalMovement = Float(gesture.translation(in: rootViewController.view).y / rootViewController.view.bounds.height)
            let progress = CGFloat(fminf(fmaxf(verticalMovement, 0.0), 1.0))
            
            interactor.shouldFinish = progress > rootViewController.percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
    
    var internalScrollView: UIScrollView?
    
    func scrollView(in view: UIView, location: CGPoint) {
        for subview in view.subviews {
            if let scrollView = view as? UIScrollView, view.frame.contains(location) {
                internalScrollView = scrollView
                break
            } else {
                _ = scrollView(in: subview, location: location)
            }
        }
    }
}

extension PopupableUsableEventDispatcher: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = rootViewController?.view else { return false }
        self.scrollView(in: view, location: touch.location(in: rootViewController?.view))
        guard let contentOffsetY = internalScrollView?.contentOffset.y else { return true }
        if contentOffsetY > CGFloat(20) {
            return false
        }
        return true
    }
}
