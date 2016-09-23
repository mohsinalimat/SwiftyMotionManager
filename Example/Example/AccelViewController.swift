//
//  ViewController.swift
//  Example
//
//  Created by Jeff Kang on 9/1/16.
//  Copyright © 2016 jeffgukang. All rights reserved.
//

import UIKit
import SwiftyMotionManager
import CoreMotion

class AccelViewController: UIViewController {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    @IBOutlet weak var aveLabel: UILabel!
    
    let swiftyMotionManager = SwiftyMotionManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        xLabel.adjustsFontSizeToFitWidth = true
        yLabel.adjustsFontSizeToFitWidth = true
        zLabel.adjustsFontSizeToFitWidth = true
        aveLabel.adjustsFontSizeToFitWidth = true
        
        swiftyMotionManager.startAccelelometerUpdatesToMotionQueue { (accellerometerData, error) in
            DispatchQueue.main.async {
                self.xLabel.text = accellerometerData?.acceleration.x.description
                self.yLabel.text = accellerometerData?.acceleration.y.description
                self.zLabel.text = accellerometerData?.acceleration.z.description
                self.aveLabel.text = accellerometerData?.acceleration.integratedData.description
            }            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
