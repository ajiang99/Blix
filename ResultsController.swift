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
    
    var softDrinkArr = [Drink]()
    
    var sections = [Section]()
    
    
/*
    var sections = [
        Section(type: "Shot",
                drinks: ["Fireball"],
                expanded: false
            )
    ]
 */
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.organizeDrinks()
        self.createSections()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                softDrinkArr.append(drink)
            default:
                break
            }
        }
    }
    
    func createSections(){
        
        if !shotArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in shotArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Shot (\(shotArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
        }
        
        if !cocktailArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in cocktailArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Cocktail (\(cocktailArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
        }

        
        if !coffeeTeaArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in coffeeTeaArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Coffee or Tea (\(coffeeTeaArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
        }

        
        if !cocoaArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in cocoaArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Cocoa (\(cocoaArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
        }

        if !homemadeLiqeuerArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in homemadeLiqeuerArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Homemade Liqeuer (\(homemadeLiqeuerArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
        }

        if !ordinaryDrinkArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in ordinaryDrinkArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Ordinary Drink (\(ordinaryDrinkArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
        }

        if !shakeArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in shakeArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Milk, Float, or Shake (\(shakeArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
        }

        if !partyDrinkArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in partyDrinkArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Party Drink (\(partyDrinkArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
        }

        if !softDrinkArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in softDrinkArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Soft Drink (\(softDrinkArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
        }
        
        if !otherArr.isEmpty{
            var drinkNameArr = [String]()
            for drink in otherArr{
                drinkNameArr.append(drink.name)
            }
            let drinkSection = Section(type: "Other (\(otherArr.count))", drinks: drinkNameArr, expanded: false)
            
            sections.append(drinkSection)
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
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            if let identifier = segue.identifier {
                if identifier == "toRecipe" {
                    let recipeViewController = segue.destination as! RecipeViewController
                    //print(sections[section].drinks.count)
                    print(sections[indexPath.section].drinks[indexPath.row])
                    print(indexPath.section)
                    //recipeViewController.drink = sections[indexPath.section].drinks[indexPath.row]
                }
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

