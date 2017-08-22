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

    @IBOutlet var instructionsText: UITextView!
    
    @IBOutlet var glassLabel: UILabel!
    
    @IBOutlet var ingredientsText: UITextView!
    
    @IBOutlet weak var descriptionView: UITextView!
    var segueID = ""
    
    @IBOutlet weak var glassType: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        print(segueID)
        if segueID == "results"{
            performSegue(withIdentifier: "unwindToResults", sender: self)
        }
        else{
            performSegue(withIdentifier: "unwindToLeft", sender: self)
        }
    }
    
    var drink: Drink?
    
    func customInit(currentDrink: Drink?){
        print(currentDrink?.name)
        guard let newDrink = currentDrink else{
            return
        }
     
        nameLabel.text = newDrink.name
        descriptionView.text = newDrink.content
        typeLabel.text = newDrink.type
        glassType.text = newDrink.glassType
        instructionsText.text = newDrink.instructions
        //glassLabel.text = newDrink.glassType
        ingredientsText.text = newDrink.ingredients
        
    }
    
    override func viewDidLoad() {
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

    }
    override func viewWillAppear(_ animated: Bool) {
        customInit(currentDrink: drink)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
