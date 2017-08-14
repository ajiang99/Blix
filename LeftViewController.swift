//
//  LeftViewController.swift
//  Blix
//
//  Created by Andrew Jiang on 7/27/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func centerFromLeft(_ sender: UISwipeGestureRecognizer) {
        print("center from left")
        performSegue(withIdentifier: "unwindFromLeft", sender: self)

    }
    
    let arrDrinks: [Drink] = DatabaseParse.getDataFromName(array: DatabaseParse.getSwiftArrayFromPlist(name: "Drinks"), info: "Cherry")
    
    var nameArr: [String] = []
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDrinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "labelCell")
        cell.textLabel?.text = nameArr[indexPath.row]
        
        return(cell)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for drink in arrDrinks{
            nameArr.append(drink.name)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toRecipeFromLeft", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(tableView.indexPathForSelectedRow!)
        if let indexPath = tableView.indexPathForSelectedRow{
            //let selectedRow = indexPath.row
            if let identifier = segue.identifier {
                if identifier == "toRecipeFromLeft" {
                    let recipeViewController = segue.destination as! RecipeViewController
                    recipeViewController.drink = arrDrinks[indexPath.row]
                }
            }
        }
        
    }
    


}
