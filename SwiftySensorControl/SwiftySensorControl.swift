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
    
    public func startAccelerometerUpdatesIfItCan() -> Bool{
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

    /** Accelerometer data will treat by handler when it update.
     */
    public func startAccelelometerUpdatesToMainQueue(handler: CMAccelerometerHandler) -> Bool {
        if !self.accelerometerAvailable {
            return false
        } else {
            super.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: handler)
            return true
        }
    }
    
    static public func accelerometerTurnOn() -> String {
        
        return "Accel On"
    }
}

public protocol SwiftySensorControlDelegate: class {
    func accelerometerUpdated(accellerometerData: CMAccelerometerData?)
}