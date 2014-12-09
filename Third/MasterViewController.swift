//
//  MasterViewController.swift
//  Third
//
//  Created by Luis Olivas on 12/1/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

/** 
:mainpage:
:author: Luis Olivas, Neil Nistler, Pradyumna Kikkeri

This is the MasterViewController and contains the TableView, viewing, and parsing functions for the OCR.
*/

import UIKit
import CoreData

/**
:brief: Data structure used to hold the receiptItem
- name: The name of the object
- cost: How much the item cost represented as an NSDecimalNumber
- datePurchased: The date the item was purchased as an NSDate
- isOut: A boolean that is set to true when the user no longer has the item
*/

struct groceryData {
    var name: String
    var cost: NSDecimalNumber
    var datePurchased: NSDate
    var isOut: Bool
}

/**

:brief: The master view controller responsible for delegating the actions of the other view controllers and storing data to the database, as well as drawing the table view


:member: managedObjectContext: Context for the CoreData delegate
:member: queueOfGroceries: A queue of groceryData structs implemented as an NSArray

*/

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate, recognizedDataDelegate {
    
    ///Context for the CoreData delegate
    var managedObjectContext: NSManagedObjectContext? = nil
    ///A queue of groceryData structs implemented as an NSArray
    var queueOfGroceries: [groceryData] = [groceryData(name: "Water", cost: 0.0, datePurchased: NSDate(), isOut: false)]
    
    // MARK: - Class initalization and setup
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /**
    :brief: Overrides viewDidLoad from superclass UIView. Sets up Typography and adds an edit button
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        let font = UIFont(name: "BebasNeueBold", size: 30)
        if let font = font {
            navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.blackColor()]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Mark: - Data Methods
    /**
    :brief: Adds receipt item to database
    :param: item A struct of type groceryData that contains the item's information
    */
    func addGroceryItemToDataBase(item: groceryData) -> () {
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        let newManagedObject: GroceryItem = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as GroceryItem
        
        newManagedObject.name = item.name
        newManagedObject.datePurchased = item.datePurchased
        newManagedObject.cost = item.cost
        newManagedObject.isOut = item.isOut
        
        var error: NSError? = nil
        if !context.save(&error) {
            abort()
        }
    }
    
    
Breaks code
    
    asldkfhja;lsdfj a;sdfj a;sf
    asldkfhja;lsdfj a;sdfj a;sf
    asldkfhja;lsdfj a;sdfj a;sf
    asldkfhja;lsdfj a;sdfj a;sf

    asldkfhja;lsdfj a;sdfj a;sf
    asldkfhja;lsdfj a;sdfj a;sf
    asldkfhja;lsdfj a;sdfj a;sf

    /**
    :brief: Delegate method of recognizedDataDelegate protocol. Passes data to this view controller from ImageRecognitionViewController
    :param: readText OCR text of a receipt
    :return: The recognized text.
    */
    func receiptWasCapturedAndRecognized(readText: String) -> String {
        parseInput(readText);
        return readText
    }
    
    /**
    :Description: Presently just does magical things. Dumbledore would have a hard time understanding how it works
    :param: text We're not even sure if it does anything with this
    */
    func parseInput(text:String) {
        //Do magical things
        let burger: groceryData = groceryData(name: "Beef Burgr", cost: 9.95, datePurchased: NSDate(), isOut: false)
        let BudLight: groceryData = groceryData(name: "Bud Light", cost: 3.79, datePurchased: NSDate(), isOut: false)
        let bud: groceryData = groceryData(name: "Bud", cost: 4.50, datePurchased: NSDate(), isOut: false)
        queueOfGroceries.append(burger)
        queueOfGroceries.append(BudLight)
        queueOfGroceries.append(bud)
    }
    // MARK: - Segues

    /**
    :brief: Overrides prepareForSegue method from UINavigationController superclass to pass infomration between view controllers
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
            let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
            (segue.destinationViewController as DetailViewController).detailItem = object
            }
        } else if segue.identifier == "addImage" {
            let secondViewController: ImageRecognitionViewController = segue.destinationViewController as ImageRecognitionViewController
            secondViewController.delegate = self
        }
    }
    
    /**
    :brief: Custom segue that populates the master view controller with the grocery items from an OCR
    */
    @IBAction func unwindToMaster(segue: UIStoryboardSegue) {
        while queueOfGroceries.count > 1 {
            addGroceryItemToDataBase(queueOfGroceries.last!)
            queueOfGroceries.removeLast()
        }
    }
    
    // MARK: - Table View
    
    /**
     * :brief: Returns the number of sections in the UI Table View.
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    /**
     * :brief: Returns the number of rows in each section of the Table View.
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    /**
     * :brief: Returns the cell at the given index path.
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    /**
     * :return: If returning true, the specified item in the table is editable. If false, the item is not editable.
    */
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    /**
    :brief: Allows editing of tableview.
    */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject)
                
            var error: NSError? = nil
            if !context.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as GroceryItem
        cell.textLabel?.text = object.name
    
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("GroceryItem", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
    	var error: NSError? = nil
    	if !_fetchedResultsController!.performFetch(&error) {
    	     // Replace this implementation with code to handle the error appropriately.
    	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             //println("Unresolved error \(error), \(error.userInfo)")
    	     abort()
    	}
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
}

