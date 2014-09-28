//
//  ViewController.swift
//  groceryTracker
//
//  Created by Luis Olivas on 9/21/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tesseract = Tesseract(language: "eng+ita")
        
        let image = UIImage(named: "image_sample.jpg")
        
        
        tesseract.setVariableValue("0123456789", forKey: "tessedit_char_whitelist")
        tesseract.image = image.blackAndWhite()
        tesseract.recognize();
        
        println(tesseract.recognizedText)
        println("Hello, World!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

