//
//  IntermediaryView.swift
//  Blix
//
//  Created by Andrew Jiang on 8/21/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import SearchTextField

class IntermediaryView: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var filterTypeKey: [String]?
    var segueID: String?
    var selfSegueID: String?
    var resultSet = Set<String>()
    var arrResultSet: [String]?
    var enteredIngredients: [String] = []
    var passedArrDrinks: [String]? 
    
    @IBOutlet weak var entryField: SearchTextField!
    @IBOutlet weak var detectedIngredientsTable: UITableView!
    @IBOutlet weak var addIngredientsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrResultSet = (Array)(resultSet) //Set to Array weird config
        configureSimpleSearchTextField()
        entryField.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "centerToResults"{ //actuallyCenterToFilter
            //let thisController = UIViewController() as! ResultsController
            //thisController.segueID = "center"
            self.filterTypeKey = ["cocktail","shot","beer","coffee","party","liqueur","ordinary","cocoa","shake","soft", "other"]
            let nav = segue.destination as! UINavigationController
            let resultsController = nav.viewControllers[0] as! FilterController
            resultsController.filterTypeKey = self.filterTypeKey
            resultsController.segueID = "center"
            resultsController.selfSegueID = "center"
            print("arr equals: \(resultsController.filterTypeKey)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        //enteredTable.beginUpdates()
        
        enteredIngredients.append(entryField.text!)
        entryField.text! = ""
        entryField.resignFirstResponder()
        print(enteredIngredients)
        /*
         for i in 0 ..< enteredIngredients.count {
         //enteredTable.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
         enteredTable.reloadRows(at: [IndexPath], with: .left)
         }
         
         enteredTable.endUpdates()
         */
        addIngredientsTable.reloadData()
        
        
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
        //if let controller = CenterViewController.self
        let arrDrinks = GlobalVariables.arrDrinks//DatabaseParse.getDataFromName(array: DatabaseParse.getJson())
        
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
        var numSections: Int?

        if tableView == addIngredientsTable{
            numSections = enteredIngredients.count
        }
        
        //print (enteredIngredients.count)
        if tableView == detectedIngredientsTable{
            numSections = (arrResultSet?.count)!
        }
        return numSections!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if tableView == addIngredientsTable{
            cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
            let ingredient = enteredIngredients[indexPath.row]
        
            cell?.textLabel?.text = ingredient

        }
        if tableView == detectedIngredientsTable{
            cell = tableView.dequeueReusableCell(withIdentifier: "detectedCell", for: indexPath)
            cell?.textLabel?.text = "tst"
            //arrResultSet?[indexPath.row]

        }
        
        return cell!
    }
    
}
