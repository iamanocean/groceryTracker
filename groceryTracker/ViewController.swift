//
//  ViewController.swift
//  groceryTracker
//
//  Created by Luis Olivas on 9/21/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import UIKit
import MobileCoreServices


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var myImage: UIImage = UIImage(named: "IMG_0240.JPG")!
    var flag: Bool = false
    
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
    func recognizeImage() -> String {
        println("Started to recognize text")
        let tesseract = Tesseract(language: "eng+ita")
        tesseract.image = myImage.grayScale()
        tesseract.recognize()
        println(tesseract.recognizedText)
        textLabel.text = tesseract.recognizedText
        return textLabel.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        doNothing(12, bar: "World")
        
        
        self.recognizeImage()
    
        
        
        // tesseract.setVariableValue("0123456789", forKey: "tessedit_char_whitelist")
       
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

