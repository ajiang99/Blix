   //
//  CenterViewController.swift
//  Blix
//
//  Created by Andrew Jiang on 7/27/17.
//  Copyright © 2017 Make School. All rights reserved.
//
//gucci
import UIKit


class CenterViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    let picker = UIImagePickerController()
    
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "rightSwipe", sender: self)

    }
    
    @IBAction func unwindToCenter(segue:UIStoryboardSegue) {
        
    }
    
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

    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "leftSwipe", sender: self)
    }
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
      /*
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Camera not found", message: "This device has no camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
 */
        
    }
    @IBOutlet var rightSwipe: UISwipeGestureRecognizer!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "swipeRight" {
                print("TO RIGHT")
            }
        }
    }
}
/*
extension CenterViewController{
    func swipeAction(swipe:UISwipeGestureRecognizer){
        switch swipe.direction.rawValue{
        case 2:
            print("let's goo")
            performSegue(withIdentifier: "swipeRight", sender: self)
        default:
            break
        }
    }
}
 */
/*
extension CenterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String : Any]){
        //let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //self.imageView.isHighlighted = false
        //self.imageView.contentMode = UIViewContentMode.scaleAspectFill
        //self.imageView.image = chosenImage
        //recgonizeImage(image : chosenImage)
        //self.resultLabel.layer.backgroundColor = UIColor.white.cgColor
        //resultLabel.text = "Analyzing . . ."
        //dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
}
 */
