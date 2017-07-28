//
//  Segue2.swift
//  Blix
//
//  Created by Andrew Jiang on 7/27/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class Segue2: UIStoryboardSegue {

    override func perform() {
        
        //credits to http://www.appcoda.com/custom-segue-animations/
        
        let firstClassView = self.source.view
        let secondClassView = self.destination.view
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        secondClassView?.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        
        if let window = UIApplication.shared.keyWindow {
            
            window.insertSubview(secondClassView!, aboveSubview: firstClassView!)
            
            UIView.animate(withDuration: 0.27, animations: { () -> Void in
                
                firstClassView?.frame = (firstClassView?.frame.offsetBy(dx: -screenWidth, dy: 0))!
                secondClassView?.frame = (secondClassView?.frame.offsetBy(dx: -screenWidth, dy: 0))!
                
            }, completion: {(Finished) -> Void in
                self.source.present(self.destination as UIViewController, animated: false, completion: nil)
                
            })
            
        }
    }
}
