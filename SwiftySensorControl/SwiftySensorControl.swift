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
    static let sharedInstance = SwiftySensorControl()
    weak public var delegate: SwiftySensorControlDelegate?
    
    override public init() {
        super.init()
        print(self.accelerometerAvailable)
        print(self.gyroAvailable)
        print(self.magnetometerAvailable)
        print(self.deviceMotionAvailable)
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
    
    /** Accelerometer data transfer to delegate.
    */
    public func startAccelelometerUpdatesToMainQueue() {
        super.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { (data, error) in
            self.delegate?.accelerometerUpdated(data)
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
    
    /** Gyro data transfer to delegate.
     */
    public func startGyroUpdatesToMainQueue() {
        super.startGyroUpdatesToQueue(NSOperationQueue.mainQueue()) { (data, error) in
            self.delegate?.gyroUpdated(data)
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


    
}

public protocol SwiftySensorControlDelegate: class {
    func accelerometerUpdated(accellerometerData: CMAccelerometerData?)
    func gyroUpdated(gyroData: CMGyroData?)
}

extension CMAcceleration {
    /** Only for average value given device regardless of direction.
     *  It can be used to find how much power is given to device.
     *  - return: sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
     */
    var integratedData: Double {
        return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
    }
}

extension CMRotationRate {
    /** Only for average value given device regardless of direction.
     *  It can be used to find how much device rotated.
     *  - return: sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
     */
    var integratedData: Double {
        return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
    }
}