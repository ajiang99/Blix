//
//  FilterSection.swift
//  Blix
//
//  Created by Andrew Jiang on 8/13/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

struct FilterSection{
    var filter: String!
    var attributes: [String]!
    var expanded: Bool!
    
    
    init(filter: String, attributes: [String], expanded: Bool ){
        self.filter = filter
        self.attributes = attributes
        self.expanded = expanded
    }
}
