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
    @IBOutlet weak var setReminderButtonLabel: UIButton!
    @IBOutlet weak var isOutLabel: UILabel!
    @IBOutlet weak var datePurchased: UILabel!
    @IBAction func pressedSwitch(sender: AnyObject) {
    }
    @IBAction func userDidClickToSetUpReminder(sender: AnyObject) {
    }

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    /**
     * :brief: Updates the user interface for the detail item.
    */

    func configureView() {
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("cost")!.description
            }
            self.navigationItem.title = detail.valueForKey("name")!.description
        }
    }

    /**
     * :brief: Does any additional setup after loading the view, typically from a nib.
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        let font = UIFont(name: "BebasNeueBook", size: 30)
        if let font = font {
            detailDescriptionLabel.font = font
            setReminderButtonLabel.setAttributedTitle(NSAttributedString(string: "Set A Reminder!", attributes: [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.blueColor()]), forState: UIControlState.Normal)
            isOutLabel.font = font
            datePurchased.font = font
            
        }
        
        
    }

    /**
     * :brief: Disposes of any resources that can be recreated.
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

