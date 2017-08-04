//
//  DatabaseParse.swift
//  Blix
//
//  Created by Andrew Jiang on 8/4/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

class DatabaseParse{
    
    static func getSwiftArrayFromPlist(name: String) -> (Array<Dictionary<String,String>>){
        let path = Bundle.main.path(forResource: name, ofType: "plist")
        var arr: NSArray?
        arr = NSArray(contentsOfFile: path!)
        return (arr as? Array<Dictionary<String,String>>)!
    }
    
    static func getDataUsingPredicate(name: String) -> (Array<[String:String]>){
        let array = getSwiftArrayFromPlist(name: "Drinks")
        let namePredicate = NSPredicate(format: "d_cat = %@", name)
        return [array.filter {namePredicate.evaluate(with: $0)}[0]]
    }
    
    static func getDataCrude(array: Array<Dictionary<String,String>>, data: String){
        for stuff in array{
            if stuff["d_name"] == data{
                print(stuff)
            }
        }
    }
    
    static func getIngredients(array: Array<Dictionary<String,String>>){
        for stuff in array{
            let str = stuff["d_shopping"]
            let array = str?.components(separatedBy: "|")
            print(array!)
        }
    }
}
