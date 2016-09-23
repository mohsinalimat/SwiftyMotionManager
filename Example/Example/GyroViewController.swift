//
//  GyroViewController.swift
//  Example
//
//  Created by Jeff Kang on 9/9/16.
//  Copyright © 2016 jeffgukang. All rights reserved.
//

import UIKit
import SwiftyMotionManager
import CoreMotion

class GyroViewController: UIViewController {
    
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
        
        swiftyMotionManager.startGyroUpdatesToMotionQueue { (gyroData, error) in
            DispatchQueue.main.async {
                self.xLabel.text = gyroData?.rotationRate.x.description
                self.yLabel.text = gyroData?.rotationRate.y.description
                self.zLabel.text = gyroData?.rotationRate.z.description
                self.aveLabel.text = gyroData?.rotationRate.integratedData.description
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
