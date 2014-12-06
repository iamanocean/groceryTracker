//
//  ThirdTests.swift
//  ThirdTests
//
//  Created by Luis Olivas on 12/1/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import UIKit
import XCTest

/**
 * :brief: This is the file of test cases and is invoked to test the app.
*/

class ThirdTests: XCTestCase {
    
    /**
     * :brief: called before invocation of each test method in the class.
    */
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    /**
     * :brief: Teardown code, called after the invocation of each test method in the class.
    */
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /**
     * :brief: Functional test case.
    */
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    /**
     * :brief: Performance test case. Measures time, amongst other performance tests.
    */
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
