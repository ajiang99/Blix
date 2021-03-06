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
    var sectionCount: Int = 0
    
    var cellCount = 0
    var count = 0
    
    var recievedIngredients: [String]?
    
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
    
    @IBAction func unwindToResults(segue:UIStoryboardSegue) { }
    
    
    var filterTypeKey: [String]!
    
    //var arrDrinks: [Drink] = GlobalVariables.arrDrinks //DatabaseParse.getDataFromName(array: DatabaseParse.getJson())
    //REDUCED ARR DRINKS SAME AS ARRDRINKS, JUST DIDN'T CHANGE NAME YET
    
    var reducedArrDrinks: [Drink] = GlobalVariables.arrDrinks
    
    //let drinkDict : [Int:String] = [0:"cocktail",1:"beer",2:"shot",3:"liqueur",4:"coffee",5:"dry", 6:"party",7:"other",8:"all"]
    
    var typeDict: [String:[Drink]] = ["cocktail":[],"beer":[],"shot":[],"liqueur":[],"coffee":[],"dry":[],"party":[],"other":[],"all":[]]
    
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        print(recievedIngredients)
        if let ingredients = recievedIngredients{
            reducedArrDrinks = DatabaseParse.filterByIngredient(reducedArrDrinks, recievedIngredients!)
        }
        super.viewDidLoad()
        //ALL DID HERE WAS REDUCED NUMBER OF DRINKS
        /*
        var count = 0
        for drink in arrDrinks{
            if count<100{
                reducedArrDrinks.append(drink)
            }
            count+=1
        }
        */
        self.organizeDrinks()
        self.createSections()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //
    func organizeDrinks(){
        for drink in reducedArrDrinks{
            //print (drink.type)
            //print(typeDict["cocktail"]?.count)
            switch drink.type{
            case "Shots & Shooters":
                typeDict["shot"]?.append(drink)
            case "Cocktails":
                typeDict["cocktail"]?.append(drink)//cocktailArr.append(drink)
            case "Beer / Ale":
                typeDict["beer"]?.append(drink)//beerArr.append(drink)
            //case "Cocoa":
                //typeDict["cocoa"]?.append(drink)//cocoaArr.append(drink)
            case "Coffee / Tea":
                typeDict["coffee"]?.append(drink)//coffeeTeaArr.append(drink)
            case "Liqueurs":
                typeDict["liqueur"]?.append(drink)//homemadeLiqeuerArr.append(drink)
            //case "Ordinary Drink":
                //typeDict["ordinary"]?.append(drink)//ordinaryDrinkArr.append(drink)
            //case "Milk / Float / Shake":
                //typeDict["shake"]?.append(drink)//shakeArr.append(drink)
            case "Other Drinks":
                typeDict["other"]?.append(drink)//otherArr.append(drink)
            case "Punches":
                typeDict["party"]?.append(drink)//partyDrinkArr.append(drink)
            //case "Soft Drinks and Soda":
                //typeDict["soft"]?.append(drink)//softDrinkArr.append(drink)
            case "Non-Alcoholic":
                typeDict["dry"]?.append(drink)
            default:
                break
            }
        }
    }
    
    func createSections(){
        if filterTypeKey.contains("all") != true
        {
            var count = 0
            
                for type in filterTypeKey{
                    
                    var drinkNameArr = [String]()
                    var drinkObjArr = [Drink()]
                        //for drink in typeDict[type]!{
                        //INDEX OUT OF RANGE
                        for index in 1...50{
                            drinkNameArr.append((typeDict[type]?[index].name)!)
                            //INDEX OUT OF RANGE FOR LIQUEUR
                            drinkObjArr.append((typeDict[type]?[index])!)
                    }      

                        //}
                    
                    //SHOWS ONLY FIRST 50
                    //drinkObjArr.removeSubrange(ClosedRange(uncheckedBounds: (lower: 51, upper: drinkObjArr.endIndex - 1)))
                    let drinkSection = Section(type: type, drinks: drinkNameArr, drinkObjs: typeDict[type]!, expanded: false)
 
                    
                    sections.append(drinkSection)
                    count+=1
                }
            
        }
        else{
            let index = filterTypeKey.index(of: "all")
            filterTypeKey.remove(at: index!)
            for type in filterTypeKey{
                var drinkNameArr = [String]()
                var drinkObjArr = [Drink()]
                //print(filterTypeKey)
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
        //sectionCount = sections[section].drinks.count
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
        
        var cell: UITableViewCell
        //print(indexPath.row)
        //print(sectionCount)
        /*
        if indexPath.row == (sectionCount - 1){
            cell = tableView.dequeueReusableCell(withIdentifier: "loadMore")!
        }
        */
        //else{
            cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
            cell.textLabel?.text = sections[indexPath.section].drinks[indexPath.row]
        //}
        
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
                    let recipeController = segue.destination as! RecipeViewController
                    recipeController.segueID = "results"
                    let recipeViewController = segue.destination as! RecipeViewController
                    recipeViewController.drink = sections[indexPath.section].drinkObjs[indexPath.row]
                }
            }
        }
    }
}

