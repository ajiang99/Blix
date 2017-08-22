//
//  DatabaseParse.swift
//  Blix
//
//  Created by Andrew Jiang on 8/4/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

class DatabaseParse{
    
    static func getJson() -> [[String: Any]]{
        /*
        let file = Bundle.main.path(forResource: "drinkRecipeFixedCSVFormatted", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: file!))
        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
        return jsonData!
        */
        
        //var drinksReal: [Dictionary<String, Dictionary<String,String>>] = []
        var drinksReal: [[String:Any]] = []
        
        do {
            let file = Bundle.main.path(forResource: "drinkRecipeFixedCSVFormatted", ofType: "json")
            if let data = try? Data(contentsOf: URL(fileURLWithPath: file!)),
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                let drinks = json["results"] as? [[String: Any]] {
                drinksReal = drinks
            }
        } catch {
            let defualt = [["Error":["defualt":0]]]
            
            print("Error deserializing JSON: \(error)")
            
            drinksReal = defualt
        }
        
        return drinksReal
    }
    
    static func getSwiftArrayFromPlist(name: String) -> (Array<Dictionary<String,String>>){
        let path = Bundle.main.path(forResource: name, ofType: "plist")
        var arr: NSArray?
        arr = NSArray(contentsOfFile: path!)
        return (arr as? Array<Dictionary<String,String>>)!
    }
    
        
    static func getDataFromName(array: [[String : Any]]) -> [Drink]{
        var arrDrinks: [Drink] = []
        for drink in array{
            
            var name: String
            //if drink["id"] as! String == drink["id"]{//data{
            guard let id = drink["id"] as? Int else{
                break
            }
            
            print(id)
            /*
            guard let name = (drink["title"] as? String).trimmingCharacters(in: .whitespacesAndNewlines) else{
                break
            }
            */
            
            //let name = (drink["title"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
            
            print(drink["title"]!)
            
            if let nameCheck = drink["title"] as? String{
                name = (drink["title"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
                print(name)
                
            }else{
                continue
            }
            
            
            /*
            guard let name = drink["title"] as? String else{
                continue
            }
            */
            
            guard let content = drink["content"] as? String else{
                continue
            }
            
            guard let type = drink["cat"] as? String else{
                continue
            }
            
            print(type)
            
            guard let subtype = drink["subcat"] as? String else{
                continue
            }
            
            print(subtype)
            guard let ingredients = drink["ingredients"] as? String else{
                continue
            }
            guard let instructions = drink["method"] as? String else{
                continue
            }
            guard let glassType = drink["serve"] as? String else{
                continue
            }
            
            guard let nutrition = drink["nutriinfo"] as? String else{
                continue
            }
            
            print(name)
            
            let drink = Drink(id, name, content, type, subtype, ingredients, instructions, glassType, nutrition)
                
            arrDrinks.append(drink)
                
            //}
        }
        print(arrDrinks.count)
        print(arrDrinks[6262].name)
        return arrDrinks
    }
    
    static func getIngredientsFromObj(drink: Drink) -> (Set<String>){
        
        let start = drink.content.index(drink.content.startIndex, offsetBy: (30 + drink.name.characters.count))
        let end = drink.content.index(drink.content.endIndex, offsetBy: -35)
        let range = start..<end
        
        let newStr = drink.content.substring(with: range)
        
        var ingredientsArr = newStr.components(separatedBy: ", ")
        
        
        var reformattedIngredientsArr: [String] = []
        
        for ingredient in ingredientsArr{
            ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
            reformattedIngredientsArr.append(ingredient)
            
            let last = reformattedIngredientsArr[reformattedIngredientsArr.endIndex - 1]
            
            let lastTwoIngredients = last.components(separatedBy: " and ")
            
            reformattedIngredientsArr.removeLast()
            
            reformattedIngredientsArr += reformattedIngredientsArr + lastTwoIngredients
            
            //let setLastIngredients = Set(reformattedIngredientsArr.endIndex.components(seperatedBy: " "))
            
            //if ingredient.
        }
        
        let setDrinks = Set(reformattedIngredientsArr)
        
        return setDrinks
        //name starts AT 23 (aka after 22) 
        //22 + name.count + 1 + 6
        //35 before 
        
        //"A delicious recipe for 57 Chevy, with vodka, Southern Comfort peach liqueur, Grand Marnier orange liqueur and pineapple juice. Also lists similar drink recipes."
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

    //Give Ingredient and filters out with drink has that ingredient
    static func filterByIngredient(_ drinks: [Drink], _ ingredients: [String]) -> [Drink]{
        var filteredArr: [Drink] = []
        let ingredientsSet = Set(ingredients)
        for drink in drinks{
            let drinkIngredients = getIngredientsFromObj(drink: drink)
            //figure out this set and array converting
            // is drinkIngredients in ingredientsSet
            print(drinkIngredients)
            print(drink)
            print(ingredientsSet)
            if ingredientsSet.isSubset(of: drinkIngredients){
                filteredArr.append(drink)
            }
        }
        return filteredArr
    }
    
    static func getDifferentIngredients(drinks: [Drink]) -> [String]{
        var ingredientsArr: [String] = []
        for drink in drinks{
            let arrTheseIngredients = getIngredientsFromObj(drink: drink)
            for ingredient in arrTheseIngredients{
                if ingredientsArr.contains(ingredient) != true{
                    ingredientsArr.append(ingredient)
                }
            }
        }
        return ingredientsArr
    }
    
    
}
