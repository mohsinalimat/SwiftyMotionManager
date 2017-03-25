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
    private let motionQueue = OperationQueue()
    
    override public init() {
        super.init()
    }
    
    
    open func stopSwiftyMotionManager() {
        super.stopAccelerometerUpdates()
        super.stopGyroUpdates()
        super.stopMagnetometerUpdates()
        super.stopDeviceMotionUpdates()
    }
    
    // MARK: Accelerometer
    
    /**
     You can get the latest accelerometer data through the accelerometerData property. You must call stopAccelerometerUpdates when you no longer want your app to process accelerometer updates.
     */
    open func startAccelerometerUpdatesIfAvailable() {
        if !self.isAccelerometerAvailable {
            ErrorLog("Accelerometer is not available")
        } else {
            super.startAccelerometerUpdates()
        }
    }

    /**
     Accelerometer data will treat by handler whenever it updates.
	
     - parameters:
        - handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMAccelerometerHandler type.
     */
    open func startAccelelometerUpdatesToMotionQueue(withHandler handler: @escaping CMAccelerometerHandler) {
        if !self.isAccelerometerAvailable {
            ErrorLog("Accelerometer is not available")
        } else {
            super.startAccelerometerUpdates(to: motionQueue, withHandler: handler)
        }
    }
    
    /** 
     Accelerometer data will treat by handler whenever it updates by interval.
     It affect the interval of accelerometer.
     
     - parameters:
        - interval: TimeInterval type. Unit is a second.
        - handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMAccelerometerHandler type.
     */
    open func startAccelelometerUpdatesToMotionQueue(byInterval interval:TimeInterval, withHandler handler: @escaping CMAccelerometerHandler) {
        if !self.isAccelerometerAvailable {
            ErrorLog("Accelerometer is not available")
        } else {
            super.accelerometerUpdateInterval = interval
            super.startAccelerometerUpdates(to: motionQueue, withHandler: handler)
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
     
     - parameters:
        - handler: A block that is invoked with each update to handle new gyro data. The block must conform to the CMGyroHandler type.
     */
    open func startGyroUpdatesToMotionQueue(withHandler handler: @escaping CMGyroHandler) {
        if !self.isGyroAvailable {
            ErrorLog("Gyro is not available")
        } else {
            super.startGyroUpdates(to: motionQueue, withHandler: handler)
        }
    }
    
    /**
     Gyro data will treat by handler whenever it updates by interval.
     It affect the interval of gyro.
     
     - parameters:
        - interval: TimeInterval type. Unit is a second.
        - handler: A block that is invoked with each update to handle new gyro data. The block must conform to the CMGyroHandler type.
     */
    open func startGyroUpdatesToMotionQueue(byInterval interval: TimeInterval, withHandler handler: @escaping CMGyroHandler) {
        if !self.isGyroAvailable {
            ErrorLog("Gyro is not available")
        } else {
            super.gyroUpdateInterval = interval
            super.startGyroUpdates(to: motionQueue, withHandler: handler)
        }
    }

    // MARK: Magnetometer
    
    open func startMagnetometerUpdatesIfAvailable() {
        if !self.isMagnetometerAvailable {
            ErrorLog("Magnetometer is not available")
        } else {
            super.startMagnetometerUpdates()
        }
    }
    
    open func startMagnetometerUpdatesToMotionQueue(withHandler handler: @escaping CMMagnetometerHandler) {
        if !self.isMagnetometerAvailable {
            ErrorLog("Magnetometer is not available")
        } else {
            super.startMagnetometerUpdates(to: motionQueue, withHandler: handler)
        }
    }
    
    open func startMagnetometerUpdatesToMotionQueue(byInterval interval: TimeInterval, withHandler handler: @escaping CMMagnetometerHandler) {
        if !self.isMagnetometerAvailable {
            ErrorLog("Gyro is not available")
        } else {
            super.magnetometerUpdateInterval = interval
            super.startMagnetometerUpdates(to: motionQueue, withHandler: handler)
        }
    }
	
    // MARK: Device motion
	
	open func startDeviceMotionUpdatesIfAvailable() {
		if !self.isDeviceMotionAvailable {
			ErrorLog("DeviceMotion is not available")
		} else {
			super.startDeviceMotionUpdates()
		}
	}
	
	/**
	 DeviceMotion data will treat by handler whenever it updates.
	
	 - parameters:
		- handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMDeviceMotionHandler type.
	 */
    open func startDeviceMotionUpdatesToMotionQueue(withHandler handler: @escaping CMDeviceMotionHandler) {
        if !self.isDeviceMotionAvailable {
            ErrorLog("Devicemotion is not available")
        } else {
        super.startDeviceMotionUpdates(to: motionQueue, withHandler: handler)
        }
    }
	
	/**
	 DeviceMotion data will treat by handler whenever it updates by interval.
	 It affect the interval of DeviceMotion.
	
	 - parameters:
		 - interval: TimeInterval type. Unit is a second.
		 - handler: A block that is invoked with each update to handle new devicemotion data. The block must conform to the CMDeviceMotionHandler type.
	*/
	open func startDeviceMotionUpdatesToMotionQueue(byInterval interval:TimeInterval, withHandler handler: @escaping CMDeviceMotionHandler) {
		if !self.isAccelerometerAvailable {
			ErrorLog("Accelerometer is not available")
		} else {
			super.deviceMotionUpdateInterval = interval
			super.startDeviceMotionUpdates(to: motionQueue, withHandler: handler)
		}
	}

}

// MARK: - Extensions

extension CMAcceleration {
    /**
     Only for absolute average value given device regardless of direction.
     It can be used to find how much power is given to device.
     
     - returns: sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
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

extension CMMagneticField {
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
