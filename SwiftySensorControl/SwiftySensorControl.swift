//
//  SwiftySensorControl.swift
//  SwiftySensorControl
//
//  Created by Jeff Kang on 9/1/16.
//  Copyright © 2016 jeffgukang. All rights reserved.
//

import Foundation
import CoreMotion

public class SwiftySensorControl: CMMotionManager {
    static public let sharedInstance = SwiftySensorControl()
    
    override public init() {
        super.init()
    }
    
    
    // MARK: Accelerometer
    
    public func startAccelerometerUpdatesIfAvailable() -> Bool{
        if !self.accelerometerAvailable {
            return false
        } else {
            super.startAccelerometerUpdates()
            return true
        }
    }
    

    /** Accelerometer data will treat by handler whenever it updates.
     */
    public func startAccelelometerUpdatesToMainQueue(handler: CMAccelerometerHandler) -> Bool {
        if !self.accelerometerAvailable {
            return false
        } else {
            super.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
            return true
        }
    }
    
    
    // MARK: Gyroscope
    
    public func startGyroUpdatesIfAvailable() -> Bool {
        if !self.gyroAvailable {
            return false
        } else {
            super.startGyroUpdates()
            return true
        }
    }    
    
    /** Gyro data will treat by handler whenever it updates.
     */
    public func startGyroUpdatesToMainQueue(handler: CMGyroHandler) -> Bool {
        if !self.gyroAvailable {
            return false
        } else {
            super.startGyroUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
            return true
        }
    }

    // TODO: Magnetometer
    
    // TODO: Device motion
    
}

// MARK: Extensions

extension CMAcceleration {
    /** Only for absolute average value given device regardless of direction.
     *  It can be used to find how much power is given to device.
     *  - return: sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
     */
    public var integratedData: Double {
        get {
            return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
        }
    }
}

extension CMRotationRate {
    /** Only for absolute average value given device regardless of direction.
     *  It can be used to find how much device rotated.
     *  - return: sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
     */
    public var integratedData: Double {
        get {
            return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
        }
    }
}

// MARK: Additional Functions
func ErrorLog(message: String = "", _ path: String = #file, _ line: Int = #line, _ function: String = #function) {
//    let file = path.componentsSeparatedByString("/").last!.componentsSeparatedByString(".").first!
    NSLog("\(path).\(line).\(function): \(message)")
}
