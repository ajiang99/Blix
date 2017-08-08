//
//  Drink.swift
//  Blix
//
//  Created by Andrew Jiang on 8/7/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

class Drink{
    
    var id = ""
    var name = ""
    var type = ""
    var alcoholicProperty = ""
    var glassType = ""
    var ingredients = ""
    var instructions = ""
    var shopping = ""
    
    init(_ id: String,_ name: String,_ type: String,_ alcoholicProperty: String,_ glassType: String,_ ingredients: String,_ instructions: String,_ shopping: String){
        self.id = id
        self.name = name
        self.type = type
        self.alcoholicProperty = alcoholicProperty
        self.glassType = glassType
        self.ingredients = ingredients
        self.instructions = instructions
        self.shopping = shopping
    }
    
    init(){
        
    }

}
