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
    /*
    static func getDataUsingPredicate(name: String) -> (Array<[String:String]>){
        let array = getSwiftArrayFromPlist(name: "Drinks")
        let namePredicate = NSPredicate(format: "d_cat = %@", name)
        return [array.filter {namePredicate.evaluate(with: $0)}[0]]
    }
    */
    static func getDataFromName(array: Array<Dictionary<String,String>>, info: String) -> [Drink]{
        var arrDrinks: [Drink] = []
        for info in array{
            if info["d_name"] == info["d_name"]{//data{
                let id = info["id"]
                let name = info["d_name"]
                let cat = info["d_cat"]
                let alcoholicProperty = info["d_alcohol"]
                let glassType = info["d_glass"]
                let ingredients = info["d_ingredients"]
                let instructions = info["d_instructions"]
                let shopping = info["d_shopping"]
                            
                let drink = Drink(id!, name!, cat!, alcoholicProperty!, glassType!, ingredients!, instructions!, shopping!)
                
                arrDrinks.append(drink)
                
            }
            //grab name let x = name
            //grab stuff let y = stuff
            //grab flavor let z = flavor
            //let drink = Drink(name: x, stuff: y, flavor, z)
            //let arrDrinks: [Drink] = []
            //arrDrinks.append(drink)
            //getDataFromName(array: Array<Dictionary<String,String>>, data: String) -> [Drink]) {
        }
        return arrDrinks
    }

    static func getIngredients(array: Array<Dictionary<String,String>>) -> (Set<String>) {
        var setDrinks = Set<String>()
        for stuff in array{
            let str = stuff["d_shopping"]
            let arrDrinks = (str?.components(separatedBy: "|"))!
            setDrinks = Set(arrDrinks)
        }
        return setDrinks
    }
    
    static func getIngredientsFromObj(drink: Drink) -> (Set<String>){
        var setDrinks = Set<String>()
        let str = drink.shopping
        let arrDrinks = (str.components(separatedBy: "|"))
        setDrinks = Set(arrDrinks)
        return setDrinks
    }
    
    //Takes drink array to be filtered and the names needed to be filtered out
    static func filterNames(drinks: [Drink], names: [String]) -> [Drink]{
        var filteredArr: [Drink] = []
        for name in names{
            for drink in drinks{
                if drink.name == name{
                    filteredArr.append(drink)
                }
            }
        }
        return filteredArr
    }
    
    //Takes drinkArr and type, returns filtreredArr
    /*static func filterName(drinks: [Drink], type: String) -> [Drink]{
        var filteredArr: [Drink] = []
        for drink in drinks{
            if drink.type == type{
                filteredArr.append(drink)
            }
        }
        return filteredArr
    }
 */
    
    static func filterTypes(drinks: [Drink], types: [String]) -> [Drink]{
        var filteredArr: [Drink] = []
        for type in types{
            for drink in drinks{
                if drink.type == type{
                    filteredArr.append(drink)
                }
            }
        }
        return filteredArr
    }
    
    static func filterIngredients(drinks: [Drink], ingredients: [String]) -> [Drink]{
        var filteredArr: [Drink] = []
        for ingredientGiven in ingredients{
            for drink in drinks{
                for ingredientSearch in getIngredientsFromObj(drink: drink){
                    if ingredientGiven == ingredientSearch{
                        filteredArr.append(drink)
                    }
                }
            }
        }
        return filteredArr
    }
    
    
    static func filterAlcoholicProperty(drinks: [Drink], property: String) -> [Drink]{
        var filteredArr: [Drink] = []
        for drink in drinks{
            if drink.alcoholicProperty == property{
                filteredArr.append(drink)
            }
        }
        return filteredArr
    }
    
    static func filterTypes(drinks: [Drink], glasses: [String]) -> [Drink]{
        var filteredArr: [Drink] = []
        for glass in glasses{
            for drink in drinks{
                if drink.glassType == glass{
                    filteredArr.append(drink)
                }
            }
        }
        return filteredArr
    }
    
    static func filterAlcoholicProperty(drinks: [Drink], id: String) -> [Drink]{
        var filteredArr: [Drink] = []
        for drink in drinks{
            if drink.id == id{
                filteredArr.append(drink)
            }
        }
        return filteredArr
    }
    
    
}
