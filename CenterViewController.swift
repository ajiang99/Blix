//
//  CenterViewController.swift
//  Blix
//
//  Created by Andrew Jiang on 7/27/17.
//  Copyright © 2017 Make School. All rights reserved.
//
//gucci
import UIKit
import Foundation

class CenterViewController: UIViewController {
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "rightSwipe", sender: self)
    }
    
    @IBAction func unwindToCenterView(segue:UIStoryboardSegue){
        
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "leftSwipe", sender: self)
    }
    override func viewDidLoad() {
      super.viewDidLoad()
        
    }
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "swipeRight" {
                print("TO RIGHT")
            }
        }
    }
}

extension CenterViewController{
    func swipeAction(swipe:UISwipeGestureRecognizer){
        switch swipe.direction.rawValue{
        case 2:
            print("let's goo")
            performSegue(withIdentifier: "swipeRight", sender: self)
        default:
            break
        }
    }
}
