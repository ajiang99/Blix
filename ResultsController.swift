//
//  ResultsController.swift
//  Blix
//
//  Created by Andrew Jiang on 8/7/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ResultsController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    @IBAction func unwindToResultsController(segue:UIStoryboardSegue) { }
    
    
    var arrDrinks: [Drink] = DatabaseParse.getDataFromName(array: DatabaseParse.getSwiftArrayFromPlist(name: "Drinks"), info: "Cherry")
    
    var shotArr = [Drink]()
    
    var cocktailArr = [Drink]()
    
    var beerArr = [Drink]()
    
    var cocoaArr = [Drink]()
    
    var coffeeTeaArr = [Drink]()
    
    var homemadeLiqeuerArr = [Drink]()
    
    var ordinaryDrinkArr = [Drink]()
    
    var shakeArr = [Drink]()
    
    var otherArr = [Drink]()
    
    var partyDrinkArr = [Drink]()
    
    var softDrink = [Drink]()
    
    var sections = [
        Section(type: "Shot",
                drinks: ["Fireball"],
                expanded: false
            )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for drink in arrDrinks{
            print (drink.name)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func organizeDrinks(){
        func organizeDrinks(){
            for drink in arrDrinks{
                switch drink.type{
                    
                case "Shot":
                    shotArr.append(drink)
                case "Cocktail":
                    cocktailArr.append(drink)
                case "Beer":
                    beerArr.append(drink)
                case "Cocoa":
                    cocoaArr.append(drink)
                case "Coffee / Tea":
                    coffeeTeaArr.append(drink)
                case "Homemade Liqueur":
                    homemadeLiqeuerArr.append(drink)
                case "Ordinary Drink":
                    ordinaryDrinkArr.append(drink)
                case "Milk / Float / Shake":
                    shakeArr.append(drink)
                case "Other/Unknown":
                    otherArr.append(drink)
                case "Punch / Party Drink":
                    partyDrinkArr.append(drink)
                case "Soft Drinks and Soda":
                    softDrink.append(drink)
                default:
                    break
                }
            }
        }
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "viewRecipe" {
                
                let button: UITableViewCell = sender as! UITableViewCell
                let RecipeViewController = segue.destination as! RecipeViewController
                let index = Int(button.accessibilityIdentifier!)//parse int from button.accessibilityIdentifier
                RecipeViewController.drink = arrDrinks[index!]
                
            }
        }
    }
    */
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].drinks.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded){
            return 44
        } else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].type, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].drinks[indexPath.row]

        
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].drinks.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toRecipe" {
                let recipeViewController = segue.destination as! RecipeViewController
                recipeViewController.drink = arrDrinks[0]
            }
        }
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

