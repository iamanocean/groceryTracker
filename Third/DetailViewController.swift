//
//  DetailViewController.swift
//  Third
//
//  Created by Luis Olivas on 12/1/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    /*!
     * @brief Updates the user interface for the detail item.
    */

    func configureView() {
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("timeStamp")!.description
            }
        }
    }

    /*!
     * @brief Does any additional setup after loading the view, typically from a nib.
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    /*!
     * @brief Disposes of any resources that can be recreated.
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

