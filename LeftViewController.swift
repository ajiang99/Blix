//
//  LeftViewController.swift
//  Blix
//
//  Created by Andrew Jiang on 7/27/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func centerFromLeft(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "unwindFromLeft", sender: self)
        
    }
    
    @IBAction func unwindToLeftView(segue:UIStoryboardSegue) { }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearching = false
    
    var filteredData:[String] = []
        
    let arrDrinks: [Drink] = DatabaseParse.getDataFromName(array: DatabaseParse.getSwiftArrayFromPlist(name: "Drinks"), info: "Cherry")
    
    var nameArr: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching{
            return filteredData.count
        }
        return arrDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "labelCell")
        if isSearching{
            cell.textLabel?.text = filteredData[indexPath.row]
        }
        else{
            cell.textLabel?.text = nameArr[indexPath.row]
        }
        
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for drink in arrDrinks{
            nameArr.append(drink.name)
        }
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toRecipeFromLeft", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            tableView.reloadData()
        }else{
            isSearching = true
            filteredData = nameArr.filter({$0.lowercased().contains(searchBar.text!.lowercased())})
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            //let selectedRow = indexPath.row
            if let identifier = segue.identifier {
                if identifier == "toRecipeFromLeft" {
                    
                    
                    //let thisController = UIViewController() as! ResultsController

                    //let nav = segue.destination as! UINavigationController
                    //let recipeController = nav.viewControllers[0] as! RecipeViewController
                    let recipeController = segue.destination as! RecipeViewController

                    recipeController.segueID = "left"

                    let recipeViewController = segue.destination as! RecipeViewController
                    recipeViewController.drink = arrDrinks[indexPath.row]
                }
            }
        }
        
    }
}
