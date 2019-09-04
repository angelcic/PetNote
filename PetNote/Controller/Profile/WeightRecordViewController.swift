//
//  WeightRecordViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/3.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import Charts

class WeightRecordViewController: BaseViewController {

    @IBOutlet weak var userSwitchLayer: UIView!
    
    @IBOutlet weak var chartLayer: UIView!
    
    @IBOutlet weak var noteLayer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChartView()
    }
    
    func setChartView() {
        let chartViewFrame = CGRect(x: 0, y: 0, width: chartLayer.frame.width, height: chartLayer.frame.height)
        let chartView = PNChartView(chartViewFrame)
        
        chartLayer.addSubview(chartView)
        chartView.setup()
    }
    
}
