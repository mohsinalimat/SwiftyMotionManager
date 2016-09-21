//
//  MagnetometerViewController.swift
//  Example
//
//  Created by Jeff Kang on 9/18/16.
//  Copyright © 2016 jeffgukang. All rights reserved.
//

import UIKit
import SwiftyMotionManager
import CoreMotion

class MagnetometerViewController: UIViewController {
    
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    @IBOutlet weak var aveLabel: UILabel!
    
    let swiftyMotionManager = SwiftyMotionManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        xLabel.adjustsFontSizeToFitWidth = true
        yLabel.adjustsFontSizeToFitWidth = true
        zLabel.adjustsFontSizeToFitWidth = true
        aveLabel.adjustsFontSizeToFitWidth = true
        
        swiftyMotionManager.startMagnetometerUpdatesToNewQueue { (magnetometerData, error) in
            DispatchQueue.main.async {
                self.xLabel.text = magnetometerData?.magneticField.x.description
                self.yLabel.text = magnetometerData?.magneticField.y.description
                self.zLabel.text = magnetometerData?.magneticField.z.description
                self.aveLabel.text = magnetometerData?.magneticField.integratedData.description
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
