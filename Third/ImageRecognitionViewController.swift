//
//  ImageRecognitionViewController.swift
//  Third
//
//  Created by Luis Olivas on 12/2/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import GPUImage

///Protocol used to pass OCR text to other view controllers
protocol recognizedDataDelegate {
    func receiptWasCapturedAndRecognized(readText: String) -> String
}

/// This is the class to provide the user with an interface for scanning their receipts. The app sets the default viewing font, brings up a camera view, and prompts the user to "scan a receipt!"
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
    
    let defaultImage: UIImage = UIImage(named: "customer receipt.jpg")!
    let cameraImage: UIImage?
    var delegate: recognizedDataDelegate? = nil
    
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
    /**
    :brief: Function that presents the user with a camera view to take a photo for OCR
    :param: sender The calling object
    */
    @IBAction func didRequestCamera(sender: AnyObject) {
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.allowsEditing = false
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    /**
    :brief: Function OCRs a default image instead of opening the camera
    :param: sender The functions caller
    */
    @IBAction func didRequestCameraRollImage(sender: AnyObject) {
        let recognizedText = recognize(defaultImage)
        if delegate != nil {
            delegate!.receiptWasCapturedAndRecognized(recognizedText)
        }
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
        /**
        :brief: Algorithm used to binarize image prior to OCR processing
        :param: sourceImage the Image to be binarized
        :return: The binarzied Image
        */
        func binarize(sourceImage: UIImage) -> UIImage {
            let grayscaleImage: UIImage = sourceImage.grayScale()
            let imageSource: GPUImagePicture = GPUImagePicture(image: grayscaleImage)
            let stillImagefilter: GPUImageAdaptiveThresholdFilter = GPUImageAdaptiveThresholdFilter()
            stillImagefilter.blurRadiusInPixels = 8.0
         
            imageSource.addTarget(stillImagefilter)
            imageSource.processImage()
            
            let returnImage: UIImage = stillImagefilter.imageByFilteringImage(image)
            
            return returnImage
        }
        
        let tesseract = Tesseract(language: "eng+ita")
        tesseract.image = binarize(image)
        tesseract.recognize()
        
        textLabel.numberOfLines = 30
        textLabel.textAlignment = .Left
        textLabel.text = tesseract.recognizedText
        return tesseract.recognizedText
    }
}
