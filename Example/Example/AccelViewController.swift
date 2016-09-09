//
//  ViewController.swift
//  Example
//
//  Created by Jeff Kang on 9/1/16.
//  Copyright © 2016 jeffgukang. All rights reserved.
//

import UIKit
import SwiftySensorControl
import CoreMotion

class AccelViewController: UIViewController, SwiftySensorControlDelegate {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    let sensorControl = SwiftySensorControl.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        xLabel.adjustsFontSizeToFitWidth = true
        yLabel.adjustsFontSizeToFitWidth = true
        zLabel.adjustsFontSizeToFitWidth = true

        sensorControl.delegate = self
        sensorControl.startAccelelometerUpdatesToMainQueue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: SwiftySensorControlDelegate
    func accelerometerUpdated(accellerometerData: CMAccelerometerData?) {
        xLabel.text = accellerometerData?.acceleration.x.description
        yLabel.text = accellerometerData?.acceleration.y.description
        zLabel.text = accellerometerData?.acceleration.z.description
    }
}