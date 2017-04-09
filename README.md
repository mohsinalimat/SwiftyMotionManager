# SwiftyMotionManager

**SwiftySenserControl** is an alternative for [CMMotionManager](https://developer.apple.com/library/ios/documentation/CoreMotion/Reference/CMMotionManager_Class/).

1. [Why SwiftyMotionManager?](#why-SwiftyMotionManager)
1. [What kind of data can SwiftyMotionManager read?](#what-kind-of-data-can-SwiftyMotionManager-read)
1. [Requirements](#requirements)
1. [Integration](#integration)
1. [Usage](#usage)

## Why SwiftyMotionManager?

First of all, Apple recommends developers to create only one instance of [CMMotionManager](https://developer.apple.com/library/ios/documentation/CoreMotion/Reference/CMMotionManager_Class/) throughout the lifetime of an app. Using multiple instances may slow down the rate of data input from the sensors.

>An app should create only a single instance of the CMMotionManager class. Multiple instances of this class can affect the rate at which data is received from the accelerometer and gyroscope.

SwiftyMotionManager uses singleton pattern so that developers never have to create an instance to get data from motion sensors. Of course, SwiftyMotionManager has all the capabilities of CMMotionManager since it is a subclass of CMMotionManager.

Additionally, There are other features that you may find useful.

## What kind of data can SwiftyMotionManager read?

- Accelerometer
- Gyro
- Magnetometer
- Device motion

plan
- Barometer

## Requirements
- iOS 8.0+
- Xcode 7+


## Integration

#### Manually (iOS 8+, OS X 10.9+)
1. for Projects, just drag and drop SwiftyMotionManager.swift to your project tree.
2. for Workspaces, include the entire SwiftyMotionManager project.


## Usage

#### Initialization

```swift
import SwiftyMotionManager

let motionManager = SwiftyMotionManager.sharedInstance
```

You can use all methods same as CMMotionManager.

#### Accelerometer

Basically, call the `func startAccelelometerUpdatesToMotionQueue(byInterval interval:TimeInterval, withHandler handler: @escaping CMAccelerometerHandler)` method can treat what you want.

or

> The value of interval property is capped to minimum and maximum values; the maximum value is determined by the maximum frequency supported by the hardware. If your app is sensitive to the intervals of acceleration data.

> Set the [accelerometerUpdateInterval](https://developer.apple.com/documentation/coremotion/cmmotionmanager/1616135-accelerometerupdateinterval) property to specify an update interval. Call the [startAccelerometerUpdates(to:withHandler:)](https://developer.apple.com/documentation/coremotion/cmmotionmanager/1616148-startaccelerometerupdates) method, passing in a block of type [CMAccelerometerHandler](https://developer.apple.com/documentation/coremotion/cmaccelerometerhandler). Accelerometer data is passed into the block as
[CMAccelerometerData](https://developer.apple.com/documentation/coremotion/cmaccelerometerdata) objects.

func startAccelerometerUpdatesIfAvailable()
```swift
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
```

func startAccelelometerUpdatesToMotionQueue(withHandler handler: @escaping CMAccelerometerHandler)
```swift
  /**
   Accelerometer data will treat by handler whenever it updates.

   - parameter handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMAccelerometerHandler type.
   */
  open func startAccelelometerUpdatesToMotionQueue(withHandler handler: @escaping CMAccelerometerHandler) {
      if !self.isAccelerometerAvailable {
          ErrorLog("Accelerometer is not available")
      } else {
          super.startAccelerometerUpdates(to: motionQueue, withHandler: handler)
      }
  }
```

func startAccelelometerUpdatesToMotionQueue(byInterval interval:TimeInterval, withHandler handler: @escaping CMAccelerometerHandler)
```swift
  /**
	Accelerometer data will treat by handler whenever it updates by interval. It affect the interval of accelerometer.

	 - parameter interval: TimeInterval type. Interval in a second.
	 - parameter handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMAccelerometerHandler type.
  */
  open func startAccelelometerUpdatesToMotionQueue(byInterval interval:TimeInterval, withHandler handler: @escaping CMAccelerometerHandler) {
      if !self.isAccelerometerAvailable {
          ErrorLog("Accelerometer is not available")
      } else {
          super.accelerometerUpdateInterval = interval
          super.startAccelerometerUpdates(to: motionQueue, withHandler: handler)
      }
  }
```

##### Example

```swift
override func viewDidLoad() {
  super.viewDidLoad()

  motionManager.startAccelelometerUpdatesToMotionQueue { (accellerometerData, error) in
      self.xLabel.text = accellerometerData?.acceleration.x.description
      self.yLabel.text = accellerometerData?.acceleration.y.description
      self.zLabel.text = accellerometerData?.acceleration.z.description
      self.aveLabel.text = accellerometerData?.acceleration.integratedData.description
  }
}
```

```swift
/**
 Accelerometer data will treat by handler whenever it updates by interval.
 It affect the interval of accelerometer.

 - parameters:
    - interval: TimeInterval type. Unit is a second.
    - handler: A block that is invoked with each update to handle new accelerometer data. The block must conform to the CMAccelerometerHandler type.
 */
func startAccelelometerUpdatesToMotionQueue(byInterval interval:TimeInterval, withHandler handler: @escaping CMAccelerometerHandler)
```

#### Gyro

##### Example
```swift
override func viewDidLoad() {
  super.viewDidLoad()
  motionManager.startGyroUpdatesToMotionQueue { (gyroData, error) in
      self.xLabel.text = gyroData?.rotationRate.x.description
      self.yLabel.text = gyroData?.rotationRate.y.description
      self.zLabel.text = gyroData?.rotationRate.z.description
      self.aveLabel.text = gyroData?.rotationRate.integratedData.description
  }
}
```

#### Magnetometer
Same with Accelerometer.

##### Example

```swift
  motionManager.startMagnetometerUpdatesToMotionQueue { (magnetometerData, error) in
      DispatchQueue.main.async {
          self.xLabel.text = magnetometerData?.magneticField.x.description
          self.yLabel.text = magnetometerData?.magneticField.y.description
          self.zLabel.text = magnetometerData?.magneticField.z.description
          self.aveLabel.text = magnetometerData?.magneticField.integratedData.description
      }
  }
```

#### DeviceMotion
DeviceMotion gives measurements of the attitude, rotation rate, and acceleration of a device.

Normaly, DeviceMotion datas reflect values applied algorithm considering surrounding fields as earth's magnetic, gravity and device bias.

Thus, User DeviceMotion if you want to use *MotionManager* datas to apply your game or applications.


##### Example

```swift
	let swiftyMotionManager = SwiftyMotionManager.sharedInstance

  // in ViewDidLoad
  swiftyMotionManager.startDeviceMotionUpdatesToMotionQueue { (devicaMotionData, error) in
			DispatchQueue.main.async {
				self.pitchLabel.text = devicaMotionData?.attitude.pitch.description
				self.rollLabel.text = devicaMotionData?.attitude.roll.description
				self.yawLabel.text = devicaMotionData?.attitude.yaw.description

				self.xLabel.text = devicaMotionData?.rotationRate.x.description
				self.yLabel.text = devicaMotionData?.rotationRate.y.description
				self.zLabel.text = devicaMotionData?.rotationRate.z.description
			}
		}
```

## Extensions

#### integratedData
Absolute average value given device regardless of direction.
It can be used to find how much power is given to device by ` sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)) `.

```
let gyrox = gyroData?.rotationRate.x
let gyroIntegratedData = gyroData?.rotationRate.integratedData
let accelIntegratedData = accelData?.ratationRate.integratedData
```
