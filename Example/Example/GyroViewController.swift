//
//  GyroViewController.swift
//  Example
//
//  Created by Jeff Kang on 9/9/16.
//  Copyright © 2016 jeffgukang. All rights reserved.
//

import UIKit
import SwiftySensorControl
import CoreMotion

class GyroViewController: UIViewController, SwiftySensorControlDelegate {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!

    let sensorControl = SwiftySensorControl.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    func gyroUpdated(gyroData: CMGyroData?) {
        xLabel.text = gyroData?.rotationRate.x.description
        yLabel.text = gyroData?.rotationRate.y.description
        zLabel.text = gyroData?.rotationRate.z.description
    }
}
