# SwiftySensorControl

**SwiftySenserControl** is an alternative for [CMMotionManager](https://developer.apple.com/library/ios/documentation/CoreMotion/Reference/CMMotionManager_Class/).

1. [Why SwiftySensorControl?](#why-swiftysensorcontrol)
1. [What kind of data can SwiftySensorControl read?](#what-kind-of-data-can-swiftysensorcontrol-read)
1. [Requirements](#requirements)
1. [Integration](#integration)
1. [Usage](#usage)

## Why SwiftySensorControl?

First of all, Apple recommends developers to create only one instance of [CMMotionManager](https://developer.apple.com/library/ios/documentation/CoreMotion/Reference/CMMotionManager_Class/) throughout the lifetime of an app. Using multiple instances may slow down the rate of data input from the sensors.

>An app should create only a single instance of the CMMotionManager class. Multiple instances of this class can affect the rate at which data is received from the accelerometer and gyroscope.

SwiftySensorControl uses singleton pattern so that developers never have to create an instance to get data from motion sensors. Of course, SwiftySensorControl has all the capabilities of CMMotionManager since it is a subclass of CMMotionManager.

Additionally, There are other features that you may find useful.

## What kind of data can SwiftySensorControl read?

- Accelerometer
- Gyro
- Magnetometer

plan
- Barometer

## Requirements
- iOS 8.0+
- Xcode 7


## Integration

#### Manually (iOS 8+, OS X 10.9+)
1. for Projects, just drag and drop SwiftySensorControl.swift to your project tree.
2. for Workspaces, include the entire SwiftySensorControl project.


## Usage

#### Initialization

```swift
import SwiftySensorControl

let sensorControl = SwiftySensorControl.sharedInstance
```

#### Accelerometer

```swift
override func viewDidLoad() {
  super.viewDidLoad()
  sensorControl.startAccelelometerUpdatesToMainQueue { (accellerometerData, error) in
      self.xLabel.text = accellerometerData?.acceleration.x.description
      self.yLabel.text = accellerometerData?.acceleration.y.description
      self.zLabel.text = accellerometerData?.acceleration.z.description
      self.aveLabel.text = accellerometerData?.acceleration.integratedData.description
  }
}
```

#### Gyro
```swift
override func viewDidLoad() {
  super.viewDidLoad()
  sensorControl.startGyroUpdatesToMainQueue { (gyroData, error) in
      self.xLabel.text = gyroData?.rotationRate.x.description
      self.yLabel.text = gyroData?.rotationRate.y.description
      self.zLabel.text = gyroData?.rotationRate.z.description
      self.aveLabel.text = gyroData?.rotationRate.integratedData.description
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
