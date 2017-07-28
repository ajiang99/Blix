//
//  LeftViewController.swift
//  Blix
//
//  Created by Andrew Jiang on 7/27/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    
    @IBAction func centerFromLeft(_ sender: UISwipeGestureRecognizer) {
        print("center from left")
        performSegue(withIdentifier: "unwindFromLeft", sender: self)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
