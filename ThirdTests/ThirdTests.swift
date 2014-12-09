//
//  ThirdTests.swift
//  ThirdTests
//
//  Created by Luis Olivas on 12/1/14.
//  Copyright (c) 2014 Luis Olivas. All rights reserved.
//

import UIKit
import XCTest
import GPUImage

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
* :brief: This is the file of test cases and is invoked to test the app.
*/
class ThirdTests: XCTestCase {
    /**
     * :brief: called before invocation of each test method in the class.
    */
    func substringToProperDateFormat(myString: String) ->  String {
        var myNewString = myString.substringWithRange(Range<String.Index>(start: advance(myString.startIndex, 0), end: advance(myString.endIndex, -15)))
        return myNewString
    }
    
    override func setUp() {
        super.setUp()
        println("App initialization successful")

    
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
    
    func testSetup() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    
    func testTruncate() {
        
        XCTAssertEqual("Hello World".truncate(5, trailing: "..."), "Hello...")

    }
    
    func testTruncateWithIndexGreaterThanStringLength() {
        
        XCTAssertEqual("Hello World".truncate(20, trailing: " "), "Hello World")
    
    }
    func testDateFormatting() {

        XCTAssertEqual(substringToProperDateFormat("2014-12-02 07:44:12 +0000"), "2014-12-02")
    }
    
    /**
     * :brief: Performance test case. Measures time, amongst other performance tests.
    */
    
    func testPerformanceExample() {
        self.measureBlock() {
        
                func binarize(sourceImage: UIImage) -> UIImage {
        
                    let imageSource: GPUImagePicture = GPUImagePicture(image: sourceImage)
                    let stillImagefilter: GPUImageAdaptiveThresholdFilter = GPUImageAdaptiveThresholdFilter()
                    stillImagefilter.blurRadiusInPixels = 8.0
                    
                    imageSource.addTarget(stillImagefilter)
                    imageSource.processImage()
                    
                    let returnImage: UIImage = stillImagefilter.imageByFilteringImage(sourceImage)
                    
                    return returnImage
                }
            
            binarize(UIImage(named: "customer receipt.jpg")!)
            
        }
    }
    
}
