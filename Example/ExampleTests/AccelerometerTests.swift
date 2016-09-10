//
//  AccelerometerTests.swift
//  Example
//
//  Created by Jeff Kang on 9/9/16.
//  Copyright © 2016 jeffgukang. All rights reserved.
//

import XCTest
import SwiftySensorControl

class AccelerometerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAccelerometerAvailable() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sensorControl = SwiftySensorControl.sharedInstance
        XCTAssertEqual(true, sensorControl.accelerometerAvailable)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
