//
//  UIViewController+Popupable.swift
//  Popupable
//
//  Created by nilhy on 05/05/2020.
//  Copyright (c) 2020 nilhy. All rights reserved.
//


import Foundation
import UIKit

extension UIViewController {
    
    enum AssociatedKeys {
        static var eventDispatcher = "eventDispatcher"
        static var dismissableTriggerTransitioning = "dismissableTriggerTransitioning"
        static var dismissableInteractor = "dismissableInteractor"
        static var showableTriggerTransitioning = "showableTriggerTransitioning"
    }
    
    var eventDispatcher: PopupableUsableEventDispatcher? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.eventDispatcher) as? PopupableUsableEventDispatcher }
        set { objc_setAssociatedObject(self, &AssociatedKeys.eventDispatcher, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
        
    var dismissableTriggerTransitioning: PopupTriggerTransitioningDelegate? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.dismissableTriggerTransitioning) as? PopupTriggerTransitioningDelegate }
        set { objc_setAssociatedObject(self, &AssociatedKeys.dismissableTriggerTransitioning, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    var dismissableInteractor: DismissInteractor? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.dismissableInteractor) as? DismissInteractor }
        set { objc_setAssociatedObject(self, &AssociatedKeys.dismissableInteractor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    var showTriggerTransitioning: PopupTriggerTransitioningDelegate? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.showableTriggerTransitioning) as? PopupTriggerTransitioningDelegate }
        set { objc_setAssociatedObject(self, &AssociatedKeys.showableTriggerTransitioning, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

}
