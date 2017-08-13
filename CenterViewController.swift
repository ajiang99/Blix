//
//  CenterViewController.swift
//  Blix
   //
   //  Created by Andrew Jiang on 7/27/17.
   //  Copyright © 2017 Make School. All rights reserved.
   //
   //gucci
import UIKit
import SwiftyJSON

class CenterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    let session = URLSession.shared
    
    var googleAPIKey = "AIzaSyB5FARJ_fHMkupZ30mjRlXub6KOrZR9o5w"
    var googleURL : URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }
    
    var result = ""
    var resultSet = Set<String>()
    var elementsToReturn = [Dictionary<String,String>()]
    var count = 0
    var arr : [String] = []
    
    //LABELS AND BUTTONS
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func unwindToCenter(segue: UIStoryboardSegue) {
    
    
    }
    
    @IBAction func loadImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
 
    @IBOutlet var labelResults: UILabel!
    
    @IBAction func takePicture(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "rightSwipe", sender: self)
        
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "leftSwipe", sender: self)
    }
    
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!
    
    func recgonizeImage(image : UIImage){
        
    }
    //VIEW LOADS
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let totArr = DatabaseParse.getSwiftArrayFromPlist(name: "Drinks")
        //print(getDataCrude(array: totArr, data: "24 karat nightmare"))
        print(DatabaseParse.getIngredients(array: totArr))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //SEGUE CONTROL
    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        if let id = identifier{
            if id == "unwindFromLeft" {
                let unwindSegue = UnwindSegue1(identifier: id, source: fromViewController, destination: toViewController, performHandler: {() -> Void in
                    
                })
                return unwindSegue
            }
            
            if id == "unwindFromRight" {
                let unwindSegue = UnwindSegue2(identifier: id, source: fromViewController, destination: toViewController, performHandler: {() -> Void in
                    
                })
                return unwindSegue
            }
        }
        return super.segueForUnwinding(to: toViewController,from: fromViewController, identifier: identifier)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "centerToResults" {
            //let thisController = UIViewController() as! ResultsController
            //thisController.segueID = "center"
            arr = ["cocktail","shot","beer","coffee","party","liqueur","ordinary","cocoa","shake","soft", "other"]
            let nav = segue.destination as! UINavigationController
            let resultsController = nav.viewControllers[0] as! ResultsController
            resultsController.filterTypeKey = arr
            resultsController.segueID = "center"
            print("arr equals: \(resultsController.filterTypeKey)")
        }
    }
}


extension CenterViewController {
    
    func analyzeResults(_ dataToParse: Data) {
        
        // Update UI on the main thread
        DispatchQueue.main.async(execute: {
            
            
            // Use SwiftyJSON to parse results
            let json = JSON(data: dataToParse)
            let errorObj: JSON = json["error"]
            
            self.imageView.isHidden = true
            self.labelResults.isHidden = false
            
            // Check for errors
            if (errorObj.dictionaryValue != [:]) {
                self.labelResults.text = "Error code \(errorObj["code"]): \(errorObj["message"])"
            } else {
                // Parse the response
                print(json)
                let responses: JSON = json["responses"][0]
                
                // Get face annotations
                
                let webDetection: JSON = responses["webDetection"]
                let webEntities: JSON = webDetection["webEntities"]
                let numberOfDrinks = webEntities.count
                
                for index in 0..<numberOfDrinks{
                    let drinkData : JSON = webEntities[index]
                    self.result += drinkData["description"].stringValue
                    self.resultSet.insert(drinkData["description"].stringValue)
                    print(self.resultSet)
                }
                self.compareWithDatabase()
                print(self.elementsToReturn)
                print(self.count)
                self.labelResults.text! = self.result
                self.performSegue(withIdentifier: "centerToResults", sender: self)
            }
        })
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        result = ""
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.isHidden = true // You could optionally display the image here by setting imageView.image = pickedImage
            //imageView.image = pickedImage
            labelResults.isHidden = true
            
            // Base64 encode the image and create the request
            //2
            let binaryImageData = base64EncodeImage(pickedImage)
            //3 Go to createRequest
            createRequest(with: binaryImageData)
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImagePNGRepresentation(newImage!)
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}


/// Networking
extension CenterViewController {
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = UIImagePNGRepresentation(image)
        
        // Resize the image if it exceeds the 2MB API limit
        if ((imagedata?.count)! > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }
        
        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    func createRequest(with imageBase64: String) {
        // Create our request URL
        //4 Pulls Request URL
        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": imageBase64
                ],
                "features": [
                    [
                        "type": "WEB_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]
        let jsonObject = JSON(jsonDictionary: jsonRequest)
        
        // Serialize the JSON
        guard let data = try? jsonObject.rawData() else {
            return
        }
        
        request.httpBody = data
        
        // Run the request on a background thread
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }
    
    func runRequestOnBackgroundThread(_ request: URLRequest) {
        // run the request
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            self.analyzeResults(data)
        }
        
        task.resume()
    }
}
extension CenterViewController{
    func compareWithDatabase(){
        let netArray = DatabaseParse.getSwiftArrayFromPlist(name: "Drinks")
        for element in netArray{
            let ingredientsSet = DatabaseParse.getIngredients(array: [element])
            let unionSet = ingredientsSet.intersection(resultSet)
            print(unionSet)
            print(unionSet.count)
            print(ingredientsSet)
            print(ingredientsSet.count)
            if Double(unionSet.count) > Double(ingredientsSet.count)*0.75{
                elementsToReturn.append(element)
                count += count + 1
            }
        }
    }
}
