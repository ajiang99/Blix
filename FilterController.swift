//
//  FilterController.swift
//  Blix
//
//  Created by Andrew Jiang on 8/13/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
//import SearchTextField

class FilterController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate{
    
    //@IBOutlet weak var entryField: SearchTextField!
    //@IBOutlet weak var entryField: SearchTextField!
    
    
    var sections = [
        FilterSection(filter:"Type",
                      attributes: ["Shot","Cocktail","Beer","Cocoa","Coffee / Tea","Homemade Liqueur","Ordinary Drink","Milk / Float / Shake","Other/Unknown","Punch / Party Drink","Soft Drinks and Soda"],
                      expanded: false),
        FilterSection(filter:"Alcoholic",
                      attributes: ["True", "False"],
            expanded: false),
        FilterSection(filter: "Add Ingredients",
                      attributes: ["Enter Ingredient"],
            expanded: false),
        FilterSection(filter: "Calories",
        attributes: ["Enter Ingredient"],
        expanded: false)
    ]
    
    //let typeDict : [Int:String] = [0:"shot",1:"cocktail",2:"beer",3:"cocoa",4:"coffee",5:"liqueur", 6:"ordinary",7:"shake",8:"other",9:"party", 10:"soft", 11: "all"]
    
    let typeDict : [Int:String] = [0:"cocktail",1:"beer",2:"shot",3:"liqueur",4:"coffee",5:"dry", 6:"party",7:"other",8:"all"]
    
    var filterTypeKey: [String]!
    
    var adjustedFilterTypeKey: [String]! = [] //defualt
    
    var alcoholic: String = "" //defualt
    
    var addedIngredientsArr:[String]!
    
    var recievedIngredients:[String]!
    
    var segueID = ""
    
    var selfSegueID = ""
    
    @IBAction func cancelButton(_ sender: Any) {
        if selfSegueID == "center"{
            performSegue(withIdentifier: "unwindToCenterFromFilter", sender: self)
        }
        else{
            performSegue(withIdentifier: "unwindToRightFromFilter", sender: self)
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        performSegue(withIdentifier: "filterToResults", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if filterTypeKey.contains("all") != true{
            sections.remove(at: 0)
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBOutlet var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].attributes.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chosenSection = sections[indexPath.section].filter
        if chosenSection == "Add Ingredients"{
            if (sections[indexPath.section].expanded){
                return 44
            } else{
                return 0
            }
        }
        else if (sections[indexPath.section].expanded){
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
        header.customInit(title: sections[section].filter, section: section, delegate: self)
     //   header.customInit(title: sections[section].filter, section: section, delegate: self as! ExpandableHeaderViewDelegate) //did not conform
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chosenSection = sections[indexPath.section].filter
        
        if chosenSection == "Add Ingredients"{
            //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "searchCell")
            //CELL DELEGATE AND STUFF
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchCell
            
            //cell.delegate = self
            
            
            cell.textLabel?.text = "Add: "
            
            cell.textLabel?.textColor = UIColor(red: 255/255, green: 252/255, blue: 232/255, alpha: 100)
            cell.backgroundColor = UIColor(red: 18/255, green: 53/255, blue: 91/255, alpha: 100)
            
            
            
            return cell

        }
            
        if chosenSection == "Calories"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "calorieCell")!
            
            cell.textLabel?.text = "Less Than: "
            
            cell.textLabel?.textColor = UIColor(red: 255/255, green: 252/255, blue: 232/255, alpha: 100)
            cell.backgroundColor = UIColor(red: 18/255, green: 53/255, blue: 91/255, alpha: 100)
            
            return cell
        }
        else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")!
        cell.textLabel?.text = sections[indexPath.section].attributes[indexPath.row]
            
        cell.textLabel?.textColor = UIColor(red: 255/255, green: 252/255, blue: 232/255, alpha: 100)
        cell.backgroundColor = UIColor(red: 18/255, green: 53/255, blue: 91/255, alpha: 100)
        
        cell.imageView?.image = UIImage(named:"btn_heart_black_outline")
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        let chosenSection = sections[indexPath.section].filter
        let selectedFilter = sections[indexPath.section].attributes[indexPath.row]
        
        if chosenSection != "Add Ingredients" && chosenSection != "Calories"{
            
            if cell?.imageView?.image == UIImage(named: "btn_heart_black_outline"){
                cell?.imageView?.image = UIImage(named: "btn_heart_red_solid")
            }
                
            else{
                cell?.imageView?.image = UIImage(named: "btn_heart_black_outline")
            }
            
            if cell?.imageView?.image == UIImage(named: "btn_heart_red_solid"){
                if chosenSection == "Type"{
                    let addType : String = typeDict[indexPath.row]!
                    adjustedFilterTypeKey.append(addType)
                }
                if chosenSection == "Alcoholic"{
                    if selectedFilter == "True"{
                        alcoholic = "Alcoholic"
                    }
                    else{
                        alcoholic = "Optional"
                    }
                    
                    //FIX THE TRUE AND FALSE LOGIC
                }
            }
            
            if cell?.imageView?.image == UIImage(named: "btn_heart_black_outline"){
                if chosenSection == "Type"{
                    let removeType : String = typeDict[indexPath.row]!
                    let indexToRemove = adjustedFilterTypeKey.index(of:removeType)
                    adjustedFilterTypeKey.remove(at: indexToRemove!)
                    print(adjustedFilterTypeKey)
                }
                if chosenSection == "Alcoholic"{
                    if selectedFilter == "True"{
                        alcoholic = "Alcoholic"
                    }
                    else{
                        alcoholic = "Optional"
                    }
                }
            }
            print(adjustedFilterTypeKey)
        }
    }
 
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        tableView.beginUpdates()
        for i in 0 ..< sections[section].attributes.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        tableView.endUpdates()
    }
    /*
    func getIngredients(cell: SearchCell) -> [String]{
        return cell.enteredIngredients
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterToResults" {
            let arrToPass = filterTypeKey + adjustedFilterTypeKey
            let nav = segue.destination as! UINavigationController
            
            let resultsController = nav.viewControllers[0] as! ResultsController
            resultsController.segueID = self.segueID
            resultsController.filterTypeKey = arrToPass
            //resultsController.recievedIngredients = recievedIngredients
            print(enteredIngredients)
            resultsController.recievedIngredients = enteredIngredients
            //print("arr equals: \(resultsController.filterTypeKey)")
            
        }
    }
    

}
