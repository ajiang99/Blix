//
//  RightViewController.swift
//  Blix
//
//  Created by Andrew Jiang on 7/27/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {
    

    @IBAction func centerFromRight(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "unwindFromRight", sender: self)
        print("center from right")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
