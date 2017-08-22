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
    let drinks = GlobalVariables.arrDrinks//DatabaseParse.getDataFromName(array: DatabaseParse.getJson())
    var passedArrDrinks: [String]?


    @IBAction func finishedButton(_ sender: Any) {
        performSegue(withIdentifier: "manualToResults", sender: self)
        //let drinksToReturn = DatabaseParse.filterByIngredient(drinks, enteredIngredients)
    }
    
    
    @IBOutlet weak var enteredTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSimpleSearchTextField()
        entryField.delegate = self
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
        enteredTable.reloadData()
        
    
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
        
        let arrDrinks = GlobalVariables.arrDrinks //DatabaseParse.getDataFromName(array: DatabaseParse.getJson())
        
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
        print (enteredIngredients.count)
        return enteredIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath)
        let ingredient = enteredIngredients[indexPath.row]
        
        cell.textLabel?.text = ingredient
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "manualToResults"{
            
            /*
            let recipeController = segue.destination as! RecipeViewController
            recipeController.segueID = "results"
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.drink = sections[indexPath.section].drinkObjs[indexPath.row]
            */
            //SOMETHING FUNKY HERE
            
            let arr = ["cocktail","shot","beer","coffee","party","liqueur","ordinary","cocoa","shake","soft", "other"]
            let nav = segue.destination as! UINavigationController
            let resultsController = nav.viewControllers[0] as! ResultsController
            //let resultsController = segue.destination as! ResultsController
            resultsController.filterTypeKey = arr //"ALL" keyword filter?
            resultsController.segueID = "center"
            //resultsController.selfSegueID = "center"
            print("arr equals: \(resultsController.filterTypeKey)")
        }
    }
    
}
