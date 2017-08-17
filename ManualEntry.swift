//
//  ManualEntry.swift
//  Blix
//
//  Created by Andrew Jiang on 8/15/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import SearchTextField

class ManualEntry: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var entryField: SearchTextField!
    
    var enteredIngredients: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        configureSimpleSearchTextField()
        entryField.delegate = self
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        enteredIngredients.append(entryField.text!)
        entryField.text! = ""
        entryField.resignFirstResponder()
        print(enteredIngredients)
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



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enteredIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)
        let ingredient = enteredIngredients[indexPath.row]
        
        cell.textLabel?.text = ingredient
        
        return cell
    }
}
