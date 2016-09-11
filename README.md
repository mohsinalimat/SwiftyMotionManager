# SwiftySensorControl

**SwiftySensorControl** helps to use various sensors' data instead of [CMMotionManager](https://developer.apple.com/library/ios/documentation/CoreMotion/Reference/CMMotionManager_Class/).

1. [Why SwiftySensorControl?](## Why is the SwiftySensorControl useful?
)
1. [What kind of sensors are there?](What-kind-of-sensor-datas-are-there-in-SwiftySensorControl?)
1. [Requirements](#requirements)
1. [Integration](#integration)
1. [Usage](#usage)

## Why is the SwiftySensorControl useful?

First of all, CMMotionManager is strongly recommended to use only a single instance. Using multiple instances can cause lack of system to rate of getting datas.

>An app should create only a single instance of the CMMotionManager class. Multiple instances of this class can affect the rate at which data is received from the accelerometer and gyroscope.

in [CMMotionManager](https://developer.apple.com/library/ios/documentation/CoreMotion/Reference/CMMotionManager_Class/)

SwiftySensorControl was made by singleton pattern. Therefore, you do not need to worry about irregular sensor data informations. Surely, it can use all CMMotionManager's features because it inherits from

```
  let sensorControl = SwiftySensorControl.sharedInstance
```

And there are other useful features that make you simple to handle sensor datas.

## What kind of sensor datas are there in SwiftySensorControl?

- Accelerometer
- Gyro
- Magnetometer

plan
- Barometer

## Requirements
- iOS 8.0+
- Xcode 7


## Integration

#### Manually (iOS 7+, OS X 10.9+)
To use this library in your project manually you may:

1. for Projects, just drag SwiftySensorControl.swift to your project tree.
2. for Workspaces, include the whole SwiftySensorControl.xcodeproj


## Usage

#### Initialization

```swift
import SwiftySensorControl
```

```swift
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
