//
//  DemoViewController.swift
//  Popupable_Example
//
//  Created by 杨海 on 2020/5/5.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Popupable

class DemoViewController: UIViewController, PopupableUsable {

    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
