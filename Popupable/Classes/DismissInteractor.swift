//
//  DismissInteractor.swift
//  Popupable
//
//  Created by nilhy on 05/05/2020.
//  Copyright (c) 2020 nilhy. All rights reserved.
//

import UIKit

open class DismissInteractor: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}
extension DismissInteractor {
    static var `default`: DismissInteractor = DismissInteractor()
}
