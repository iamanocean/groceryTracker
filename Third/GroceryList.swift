//
//  GroceryList.swift
//  Third
//
//  Created by Luis Olivas on 12/1/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import Foundation
import CoreData

/**
 * :brief: GroceryList object creation.
 * :param: numberOfItems Number of grocery items.
 * :param: groceryItem An instance of the groceryItem class
*/

class GroceryList: NSManagedObject {

    @NSManaged var numberOfItems: NSNumber
    @NSManaged var groceryItem: NSManagedObject

}
