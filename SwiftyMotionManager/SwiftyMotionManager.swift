//
//  SwiftyMotionManager.swift
//  SwiftyMotionManager
//
//  https://github.com/JeffGuKang/SwiftyMotionManager
//  Copyright © 2016 jeffgukang. All rights reserved.
//

import Foundation
import CoreMotion

open class SwiftyMotionManager: CMMotionManager {
    static open let sharedInstance = SwiftyMotionManager()
    
    override public init() {
        super.init()
    }
    
    
    // MARK: Accelerometer
    
    /**
     You can get the latest accelerometer data through the accelerometerData property. You must call stopAccelerometerUpdates when you no longer want your app to process accelerometer updates.
     */
    open func startAccelerometerUpdatesIfAvailable() -> Bool{
        if !self.isAccelerometerAvailable {
            return false
        } else {
            super.startAccelerometerUpdates()
            return true
        }
    }

    /**
     Accelerometer data will treat by handler whenever it updates.
     - parameter handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMAccelerometerHandler type.
     */
    open func startAccelelometerUpdatesToMainQueue(withHandler handler: @escaping CMAccelerometerHandler) {
        if !self.isAccelerometerAvailable {
            ErrorLog("Accelerometer is not available")
        } else {
            super.startAccelerometerUpdates(to: OperationQueue.main, withHandler: handler)
        }
    }
    
    /** 
     Accelerometer data will treat by handler whenever it updates by interval.
     - parameter interval: TimeInterval type. Unit is a second.
     - parameter handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMAccelerometerHandler type.
     */
    open func startAccelelometerUpdatesToMainQueue(byInterval interval:TimeInterval, withHandler handler: @escaping CMAccelerometerHandler) {
        if !self.isAccelerometerAvailable {
            ErrorLog("Accelerometer is not available")
        } else {
            super.accelerometerUpdateInterval = interval
            super.startAccelerometerUpdates(to: OperationQueue.main, withHandler: handler)
        }
    }
    
    // MARK: Gyroscope
    
    /**
     You can get the latest gyro data through the gyroData property. You must call stopGyroUpdates when you no longer want your app to process gyro updates.
    */
    open func startGyroUpdatesIfAvailable() {
        if !self.isGyroAvailable {
            ErrorLog("Gyro is not available")
        } else {
            super.startGyroUpdates()
        }
    }    
    
    /**
     Gyro data will treat by handler whenever it updates.
     - parameter handler: A block that is invoked with each update to handle new gyro data. The block must conform to the CMGyroHandler type.
     */
    open func startGyroUpdatesToMainQueue(withHandler handler: @escaping CMGyroHandler) -> Bool {
        if !self.isGyroAvailable {
            return false
        } else {
            super.startGyroUpdates(to: OperationQueue.main, withHandler: handler)
            return true
        }
    }
    
    /**
     Gyro data will treat by handler whenever it updates.
     - parameter interval: TimeInterval type. Unit is a second.
     - parameter handler: A block that is invoked with each update to handle new gyro data. The block must conform to the CMGyroHandler type.
     */
    open func startGyroUpdatesToMainQueue(byInterval interval: TimeInterval, withHandler handler: @escaping CMGyroHandler) {
        if !self.isGyroAvailable {
            ErrorLog("Gyro is not available")
        } else {
            super.gyroUpdateInterval = interval
            super.startGyroUpdates(to: OperationQueue.main, withHandler: handler)
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

func ErrorLog(_ message: String = "", _ path: String = #file, _ line: Int = #line, _ function: String = #function) {
//    let file = path.componentsSeparatedByString("/").last!.componentsSeparatedByString(".").first!
    NSLog("\(path).\(line).\(function): \(message)")
}
