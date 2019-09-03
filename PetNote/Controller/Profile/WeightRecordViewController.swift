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
    
    var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView = LineChartView()
        chartView.frame = CGRect(x: 20,
                                 y: 20,
                                 width: chartLayer.bounds.width - 40 ,
                                 height: chartLayer.bounds.height - 40)
        
        chartLayer.addSubview(chartView)
        
        chartView.scaleXEnabled = true
        chartView.legend
        //生成20条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<20 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "體重")
        
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        //设置折现图数据
        chartView.data = chartData
    }
}
