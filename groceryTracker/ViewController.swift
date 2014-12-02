//
//  ViewController.swift
//  groceryTracker
//
//  Created by Luis Olivas on 9/21/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol InformationDelegate {
    func receiptWasScannedAndRead(data: String, date: NSDate)
}


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var myImage: UIImage = UIImage(named: "receipt.gif")!
    var flag: Bool = false
    
    var delegate: InformationDelegate! = nil
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
            println("I've got an image")
        
            picker.presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            })
    }
    
    @IBOutlet var textLabel: UILabel!
    @IBAction func addImageFromCamera(sender: UIButton) {
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.allowsEditing = false
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        self.recognizeImage(myImage)
    }


    /**
        Lorem ipsum dolor sit amet.
    
        :param: foo Consectetur adipiscing elit.
    
        :param: bar Consectetur adipisicing elit.
    
        :returns: Sed do eiusmod tempor.
    */
    func doNothing(foo: Int, bar: String){
        println("Hello \(bar): \(foo)")
    }

    /**
        Initializes a tesseract object that processes an image and returns the results
    
        :param: image A UIImage object that has been binarized so that tesseract can recognize it.
    
        :returns: A String object containing the processed text.
    */
    func recognizeImage(image: UIImage) -> String {
        println("Started to recognize text")
        let tesseract = Tesseract(language: "eng+ita")
        tesseract.image = image.grayScale()
        tesseract.recognize()
        textLabel.text = tesseract.recognizedText
        
        //if (delegate != nil) {
            delegate!.receiptWasScannedAndRead(textLabel.text!, date: NSDate())
        //}
        return textLabel.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        doNothing(12, bar: "World")
        
        
    
    
        
        
        // tesseract.setVariableValue("0123456789", forKey: "tessedit_char_whitelist")
       
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

