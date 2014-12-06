//
//  ImageRecognitionViewController.swift
//  Third
//
//  Created by Luis Olivas on 12/2/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//
protocol recognizedDataDelegate {
    func receiptWasCapturedAndRecognized(readText: String) -> String
}

/**
 * :brief: This is the class to provide the user with an interface for scanning their\n
 * receipts. The app sets the default viewing font, brings up a camera view, and prompts\n
 * the user to "scan a receipt!"\n
*/

class ImageRecognitionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.hidden = true
        
        let font = UIFont(name: "BebasNeueBook", size: 30)
        if let font = font {
            textLabel.font = font
            doneButton.titleLabel?.font = font
            selectFromCameraButton.titleLabel?.font = font
            selectFromCameraRollButton.titleLabel?.font = font
        }
        
        textLabel.text = "Scan a receipt!"
    }
    
    ///ToDo Error check me
    let defaultImage: UIImage = UIImage(named: "customer receipt.jpg")!
    let cameraImage: UIImage?
    let delegate: recognizedDataDelegate? = nil
    
    @IBOutlet var selectFromCameraButton: UIButton!
    @IBOutlet var selectFromCameraRollButton: UIButton!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.presentingViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.delegate?.receiptWasCapturedAndRecognized(self.recognize(image))
            return Void()
        })
    }
    
    @IBAction func didRequestCamera(sender: AnyObject) {
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.allowsEditing = false
        self.presentViewController(imagePickerController, animated: true, completion: nil)

    }
    
    @IBAction func didRequestCameraRollImage(sender: AnyObject) {
        println("\(recognize(defaultImage)) Hello World")
        selectFromCameraButton.hidden = true
        selectFromCameraRollButton.hidden = true
        doneButton.hidden = false
    }
    
    /**
     * :brief: Tesseract's OCR function.
     * :param: UIImage This is the image that gets passed into the OCR function.
     * :returns: The text as perceived by Tesseract Optical Character Recognition.
    */

    func recognize(image: UIImage) -> String {
        let tesseract = Tesseract(language: "eng+ita")
        tesseract.image = image.grayScale()
        tesseract.recognize()
        
        textLabel.numberOfLines = 30
        textLabel.textAlignment = .Left
        textLabel.text = tesseract.recognizedText
        return tesseract.recognizedText
    }
}
