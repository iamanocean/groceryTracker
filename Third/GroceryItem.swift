//
//  GroceryItem.swift
//  Third
//
//  Created by Luis Olivas on 12/1/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import Foundation
import CoreData

class GroceryItem: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var cost: NSDecimalNumber
    @NSManaged var datePurchased: NSDate
    @NSManaged var isOut: NSNumber
    @NSManaged var groceryList: GroceryList

}
