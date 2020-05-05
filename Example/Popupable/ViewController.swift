//
//  ViewController.swift
//  Popupable
//
//  Created by nilhy on 05/05/2020.
//  Copyright (c) 2020 nilhy. All rights reserved.
//

import UIKit
import Popupable

class ViewController: UIViewController , PopupTriggerUsable {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func show() {
        
        let vc = DemoViewController()
        vc.setup(self)
        present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

