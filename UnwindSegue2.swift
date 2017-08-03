//
//  UnwindSegue2.swift
//  Blix
//
//  Created by Andrew Jiang on 7/28/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class UnwindSegue2: UIStoryboardSegue {
    override func perform(){
        let secondClassView = self.source.view
        let firstClassView = self.destination.view
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        firstClassView?.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        if let window = UIApplication.shared.keyWindow {
            
            window.insertSubview(firstClassView!, aboveSubview: secondClassView!)
            UIView.animate(withDuration: 0.27, animations: { () -> Void in
                
                firstClassView?.frame = (firstClassView?.frame.offsetBy(dx: screenWidth, dy: 0))!
                secondClassView?.frame = (secondClassView?.frame.offsetBy(dx: screenWidth, dy: 0))!
                
            }, completion: {(Finished) -> Void in
                
                self.destination.dismiss(animated: false, completion: nil)
                
            })
            
        }
        
    }
    
    

}
