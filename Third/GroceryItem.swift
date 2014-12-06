//
//  GroceryItem.swift
//  Third
//
//  Created by Luis Olivas on 12/1/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import Foundation
import CoreData

/**
 * :brief: GroceryItem object creation.
 * :param: name Name of the item.
 * :param: cost Cost of the item to two decimal places.
 * :param: datePurchased Date the item was purchased as indicated by the receipt.
 * :param: isOut Is the item out?
 * :param: groceryList An instance of the GroceryList class.
*/

class GroceryItem: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var cost: NSDecimalNumber
    @NSManaged var datePurchased: NSDate
    @NSManaged var isOut: NSNumber
    @NSManaged var groceryList: GroceryList

}
