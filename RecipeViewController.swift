//
//  RecipeViewController.swift
//  Blix
//
//  Created by Andrew Jiang on 8/7/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var typeLabel: UILabel!
    
    @IBOutlet var alcoholicPropertyLabel: UILabel!

    @IBOutlet var instructionsText: UITextView!
    
    @IBOutlet var glassLabel: UILabel!
    
    @IBOutlet var ingredientsText: UITextView!
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToResultsController", sender: self)
    }


    var drink: Drink?
    
    func customInit(currentDrink: Drink?){
        print(currentDrink?.name)
        guard let newDrink = currentDrink else{
            return
        }
        print(newDrink.name)
        print(newDrink.type)
        nameLabel.text = newDrink.name
        typeLabel.text = newDrink.type
        alcoholicPropertyLabel.text = newDrink.alcoholicProperty
        instructionsText.text = newDrink.instructions
        glassLabel.text = newDrink.glassType
        ingredientsText.text = newDrink.ingredients
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customInit(currentDrink: drink)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
