//
//  SearchCell.swift
//  Blix
//
//  Created by Andrew Jiang on 8/20/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import SearchTextField

class SearchCell: UITableViewCell, UITextFieldDelegate{
    @IBOutlet weak var entryField: SearchTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSimpleSearchTextField()
        entryField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        //enteredTable.beginUpdates()
        
        entryField.text! = ""
        entryField.resignFirstResponder()
        /*
         for i in 0 ..< enteredIngredients.count {
         //enteredTable.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
         enteredTable.reloadRows(at: [IndexPath], with: .left)
         }
         
         enteredTable.endUpdates()
         */
        
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        entryField.backgroundColor = UIColor.lightGray
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    // It is called when text field going to inactive
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.backgroundColor = UIColor.white
        return true
    }
    
    // It is called when text field is inactive
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    
    func configureSimpleSearchTextField() {
        
        let arrDrinks = DatabaseParse.getDataFromName(array: DatabaseParse.getJson())
        
        var drinkNameArr: [String] = []
        for drink in arrDrinks{
            drinkNameArr.append(drink.name)
        }
        entryField.filterStrings(drinkNameArr)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //WHAT DOES THIS DOO
        //view.endEditing(true) 

    }
    
    

    

}
