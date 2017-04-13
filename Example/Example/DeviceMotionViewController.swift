//
//  MagnetometerViewController.swift
//  Example
//
//  Created by Jeff Kang on 3/12/17.
//  Copyright © 2016 jeffgukang. All rights reserved.
//

import UIKit
import SwiftyMotionManager
import CoreMotion

class DeviceMotionViewController: UIViewController {
	
	@IBOutlet weak var rollLabel: UILabel!
	@IBOutlet weak var pitchLabel: UILabel!
	@IBOutlet weak var yawLabel: UILabel!
	@IBOutlet weak var xLabel: UILabel!
	@IBOutlet weak var yLabel: UILabel!
	@IBOutlet weak var zLabel: UILabel!
	
	let swiftyMotionManager = SwiftyMotionManager.sharedInstance
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		rollLabel.adjustsFontSizeToFitWidth = true
		pitchLabel.adjustsFontSizeToFitWidth = true
		yawLabel.adjustsFontSizeToFitWidth = true
		xLabel.adjustsFontSizeToFitWidth = true
		yLabel.adjustsFontSizeToFitWidth = true
		zLabel.adjustsFontSizeToFitWidth = true	
		
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
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
