//
//  CalorieCell.swift
//  Blix
//
//  Created by Andrew Jiang on 8/21/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class CalorieCell: UITableViewCell, UITextFieldDelegate {
    
    var calories: String?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        calorieInput.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var calorieInput: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        //calorieInput.text? = calories!
        

        calories = calorieInput.text
        
        print(calorieInput.text)
        
        calorieInput.resignFirstResponder()
        
        print(calories!)

        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        calorieInput.backgroundColor = UIColor.lightGray
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.backgroundColor = UIColor.white
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //WHAT DOES THIS DOO
        //view.endEditing(true)
        
    }
    
    
    


}
