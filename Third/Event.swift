//
//  Event.swift
//  Third
//
//  Created by Luis Olivas on 12/3/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import Foundation
import CoreData

/*!
 * @brief Event class. It assigns the variable "timeStamp" to the current system date & time.
*/

class Event: NSManagedObject {

    @NSManaged var timeStamp: NSDate

}
