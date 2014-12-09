//
//  DetailViewController.swift
//  Third
//
//  Created by Luis Olivas on 12/1/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//
/**
:mainpage:
:author: Luis Olivas
This is the detailViewController that draws information about a receipt item.
*/



import UIKit

/**
:Description: Extends the String type with a truncate method
*/
extension String {
    /// Truncates the string to length number of characters and
    /// appends optional trailing string if longer
    func truncate(length: Int, trailing: String? = nil) -> String {
        if countElements(self) > length {
            return self.substringToIndex(advance(self.startIndex, length)) + (trailing ?? "")
        } else {
            return self
        }
    }
}


/**
:brief: This class diplays the data from a tableview detail. The following are outlets to the user interace and are used to customize the class
- detailDescriptionLabel:
- isOutLabel:
- datePurchased:
- pressedSwitch:
*/
class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var isOutLabel: UILabel!
    @IBOutlet weak var datePurchased: UILabel!
    @IBAction func pressedSwitch(sender: AnyObject) {
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
                let cost = detail.valueForKey("cost")! as Float
                let adjustedCost: String = "\(cost)"
                adjustedCost.truncate(4, trailing: " ")
                label.text = "Cost: " + adjustedCost
                
            }
            let data: NSDate? = self.detailItem?.valueForKey("datePurchased") as? NSDate
            var myString:String = "\(data!)"
            println(myString)
            //myString = myString.substringWithRange(Range<String.Index>(start: advance(myString.startIndex, 0), end: advance(myString.endIndex, -15)))
            //println(myString)
            //datePurchased.text = "Date Purchased: \(myString)"
            self.navigationItem.title = detail.valueForKey("name")!.description
            //datePurchased.text = detail.valueForKey("datePurchased")?.description
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
            //setReminderButtonLabel.setAttributedTitle(NSAttributedString(string: "Set A Reminder!", attributes: [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.blueColor()]), forState: UIControlState.Normal)
            isOutLabel.font = font
            //datePurchased.font = font
        }
    }
    /**
     * :brief: Disposes of any resources that can be recreated.
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

