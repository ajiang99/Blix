//
//  RightViewController.swift
//  Blix
//
//  Created by Andrew Jiang on 7/27/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class RightViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let array:[String] = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    
    var arr:[String] = []
    
    let drinkDict : [Int:String] = [0:"cocktail",1:"shot",2:"beer",3:"coffee",4:"party",5:"liqueur", 6:"ordinary",7:"cocoa",8:"shake",9:"soft", 10:"other", 11: "all"]

    @IBAction func centerFromRight(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "unwindFromRight", sender: self)
    }
    
    @IBAction func unwindToRightView(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        collectionView.collectionViewLayout = layout
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    //Number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    //Populate Views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DrinkTypeCell
        cell.imageView.image = UIImage(named: array[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        arr = []
        arr.append(drinkDict[indexPath.item]!)
        performSegue(withIdentifier: "rightViewToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rightViewToResults" {
                let nav = segue.destination as! UINavigationController
            
                let resultsController = nav.viewControllers[0] as! ResultsController
                resultsController.segueID = "right"
                resultsController.filterTypeKey = arr
                print("arr equals: \(resultsController.filterTypeKey)")

        }
    }
}
