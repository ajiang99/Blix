//
//  Section.swift
//  Blix
//
//  Created by Andrew Jiang on 8/7/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

struct Section{
    var type: String!
    var drinks: [String]!
    var drinkObjs: [Drink]!
    var expanded: Bool!
    
    
    init(type: String, drinks: [String], drinkObjs: [Drink], expanded: Bool ){
        self.type = type
        self.drinks = drinks
        self.drinkObjs = drinkObjs
        self.expanded = expanded
    }
}
