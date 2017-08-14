//
//  ResultsController.swift
//  Blix
//
//  Created by Andrew Jiang on 8/7/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ResultsController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {
    
    var segueID = ""
    
    @IBOutlet var tableView: UITableView!

    @IBAction func filterButton(_ sender: Any) {
        performSegue(withIdentifier: "resultsToFilter", sender: self)
    }
    
    
    @IBAction func unwindToRight(_ sender: Any) {
        if segueID == "center"{
            performSegue(withIdentifier: "unwindToCenter", sender: self)
        }
        
        else{
            performSegue(withIdentifier: "unwindToRight", sender: self)
        }
        
        segueID = ""
    }

    var filterTypeKey: [String]!
    
    var arrDrinks: [Drink] = DatabaseParse.getDataFromName(array: DatabaseParse.getSwiftArrayFromPlist(name: "Drinks"), info: "Cherry")
    
    var typeDict: [String:[Drink]] = ["shot":[],"cocktail":[],"beer":[],"cocoa":[],"coffee":[],"liqueur":[],"ordinary":[],"shake":[],"other":[],"party":[],"soft":[]]
    
    var sections = [Section]()
    
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
    //
    func organizeDrinks(){
        for drink in arrDrinks{
            switch drink.type{
            case "Shot":
                typeDict["shot"]?.append(drink)
            case "Cocktail":
                typeDict["cocktail"]?.append(drink)//cocktailArr.append(drink)
            case "Beer":
                typeDict["beer"]?.append(drink)//beerArr.append(drink)
            case "Cocoa":
                typeDict["cocoa"]?.append(drink)//cocoaArr.append(drink)
            case "Coffee / Tea":
                typeDict["coffee"]?.append(drink)//coffeeTeaArr.append(drink)
            case "Homemade Liqueur":
                typeDict["liqueur"]?.append(drink)//homemadeLiqeuerArr.append(drink)
            case "Ordinary Drink":
                typeDict["ordinary"]?.append(drink)//ordinaryDrinkArr.append(drink)
            case "Milk / Float / Shake":
                typeDict["shake"]?.append(drink)//shakeArr.append(drink)
            case "Other/Unknown":
                typeDict["other"]?.append(drink)//otherArr.append(drink)
            case "Punch / Party Drink":
                typeDict["party"]?.append(drink)//partyDrinkArr.append(drink)
            case "Soft Drinks and Soda":
                typeDict["soft"]?.append(drink)//softDrinkArr.append(drink)
            default:
                break
            }
        }
    }
    
    
    func createSections(){
        
        
        if filterTypeKey.contains("all") != true
        {
            for type in filterTypeKey{
                var drinkNameArr = [String]()
                var drinkObjArr = [Drink()]
                for drink in typeDict[type]!{
                    drinkNameArr.append(drink.name)
                    drinkObjArr.append(drink)
                }
            
                let drinkSection = Section(type: type, drinks: drinkNameArr, drinkObjs: typeDict[type]!, expanded: false)
            
                sections.append(drinkSection)
            }
        }
        else{
            
            
            /*
            var drinkNameArr = [String()]
            var drinkObjArr = [Drink()]
            for drink in arrDrinks{
                drinkNameArr.append(drink.name)
                drinkObjArr.append(drink)
            }
            let allDrinks = Section(type: "All", drinks: drinkNameArr, drinkObjs: drinkObjArr, expanded: false)
            
            sections.append(allDrinks)
            */
            filterTypeKey = ["shot","cocktail","beer","cocoa","coffee","liqueur","ordinary","shake","other","party","soft"]
            for type in filterTypeKey{
                var drinkNameArr = [String]()
                var drinkObjArr = [Drink()]
                for drink in typeDict[type]!{
                    drinkNameArr.append(drink.name)
                    drinkObjArr.append(drink)
                }
                
                let drinkSection = Section(type: type, drinks: drinkNameArr, drinkObjs: typeDict[type]!, expanded: false)
                
                sections.append(drinkSection)
            }
        }
        
        
    }
    
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
                    recipeViewController.drink = sections[indexPath.section].drinkObjs[indexPath.row]
                }
            }
        }
    }
}

