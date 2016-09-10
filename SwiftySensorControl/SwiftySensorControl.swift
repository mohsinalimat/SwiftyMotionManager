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
    
    /**
     You can get the latest accelerometer data through the accelerometerData property. You must call stopAccelerometerUpdates when you no longer want your app to process accelerometer updates.
     */
    public func startAccelerometerUpdatesIfAvailable() -> Bool{
        if !self.accelerometerAvailable {
            return false
        } else {
            super.startAccelerometerUpdates()
            return true
        }
    }

    /**
     Accelerometer data will treat by handler whenever it updates.
     - parameter handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMAccelerometerHandler type.
     
     - returns: Return false when accelerometer is not available.
     */
    public func startAccelelometerUpdatesToMainQueue(withHandler handler: CMAccelerometerHandler) -> Bool {
        if !self.accelerometerAvailable {
            return false
        } else {
            super.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
            return true
        }
    }
    
    /** 
     Accelerometer data will treat by handler whenever it updates by interval.
     - parameter handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMAccelerometerHandler type.
     
     - returns: Return false when accelerometer is not available.
     */
    public func startAccelelometerUpdatesToMainQueue(byInterval interval:NSTimeInterval, withHandler handler: CMAccelerometerHandler) -> Bool {
        if !self.accelerometerAvailable {
            return false
        } else {
            super.accelerometerUpdateInterval = interval
            super.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
            return true
        }
    }
    
    // MARK: Gyroscope
    
    /**
     You can get the latest gyro data through the gyroData property. You must call stopGyroUpdates when you no longer want your app to process gyro updates.
    */
    public func startGyroUpdatesIfAvailable() -> Bool {
        if !self.gyroAvailable {
            return false
        } else {
            super.startGyroUpdates()
            return true
        }
    }    
    
    /** 
     Gyro data will treat by handler whenever it updates.
     */
    public func startGyroUpdatesToMainQueue(withHandler handler: CMGyroHandler) -> Bool {
        if !self.gyroAvailable {
            return false
        } else {
            super.startGyroUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
            return true
        }
    }
    
    public func startGyroUpdatesToMainQueue(byInterval interval: NSTimeInterval, withHandler handler: CMGyroHandler) -> Bool {
        if !self.gyroAvailable {
            return false
        } else {
            super.gyroUpdateInterval = interval
            super.startGyroUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
            return true
        }
    }

    // TODO: Magnetometer
    
    // TODO: Device motion
    
}

// MARK: - Extensions

extension CMAcceleration {
    /**
     Only for absolute average value given device regardless of direction.
     It can be used to find how much power is given to device.
     
     -returns: sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
     */
    public var integratedData: Double {
        get {
            return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
        }
    }
}

extension CMRotationRate {
    /**
     Only for absolute average value given device regardless of direction.
     It can be used to find how much device rotated.
     
     -returns: sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
     */
    public var integratedData: Double {
        get {
            return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
        }
    }
}

// MARK: - Additional Functions

func ErrorLog(message: String = "", _ path: String = #file, _ line: Int = #line, _ function: String = #function) {
//    let file = path.componentsSeparatedByString("/").last!.componentsSeparatedByString(".").first!
    NSLog("\(path).\(line).\(function): \(message)")
}
