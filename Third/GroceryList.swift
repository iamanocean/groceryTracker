//
//  GroceryList.swift
//  Third
//
//  Created by Luis Olivas on 12/1/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import Foundation
import CoreData

class GroceryList: NSManagedObject {

    @NSManaged var numberOfItems: NSNumber
    @NSManaged var groceryItem: NSManagedObject

}
