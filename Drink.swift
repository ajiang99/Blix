//
//  Drink.swift
//  Blix
//
//  Created by Andrew Jiang on 8/7/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

class Drink{
    
    var id: Int
    var name = ""
    var content = ""
    var type = ""
    var subtype = ""
    var glassType = ""
    var ingredients = ""
    var instructions = ""
    var nutrition = ""
    var alcoholicProperty = ""
    
    init(_ id: Int,_ name: String,_ content: String,_ type: String,_ subtype: String,_ ingredients: String,_ instructions: String,_ glassType: String,_ nutrition: String){
        self.id = id
        self.name = name
        self.content = content
        self.type = type
        self.subtype = subtype
        self.ingredients = ingredients
        self.instructions = instructions
        self.glassType = glassType
        self.nutrition = nutrition
        self.alcoholicProperty = "true"
    }
    /*
    init(_ id: String,_ name: String,_ content: String,_ type: String,_ subtype: String,_ alcoholicProperty: String,_ glassType: String,_ ingredients: String,_ instructions: String,_ shopping: String){
        self.id = id,
        self.name = name
        self.content = content
        self.type = type
        self.alcoholicProperty = "true"
        self.glassType = glassType
        self.ingredients = ingredients
        self.instructions = instructions
        self.shopping = shopping
    }
    */
    
    init(){
        self.id = 1
        self.name = "N/A"
        self.content = "N/A"
        self.type = "N/A"
        self.subtype = "N/A"
        self.ingredients = "N/A"
        self.instructions = "N/A"
        self.glassType = "N/A"
        self.nutrition = "N/A"
        self.alcoholicProperty = "true"
    }
 

}
