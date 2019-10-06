//
//  ChartView.swift
//  PetNote
//
//  Created by iching chen on 2019/9/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import Charts

class PNChartView: UIView {
    var chartView: LineChartView!
    
    weak var delegate: PNChartViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupChartView(entries: [ChartDataEntry], xValues: [String]? = nil, yValues: [String]? = nil) {
        
        chartView = LineChartView()
        chartView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: self.frame.width,
                                 height: self.frame.height)
        
        self.addSubview(chartView)
        chartView.legend.form = .none // 左下折線圖名稱前的圖形
        setupAxis(xValues: xValues, yValues: yValues)
        setupData(entries: entries)
        notifyDataChanged()
    }
    
    func setupAxis(xValues: [String]?, yValues: [String]? = nil) {
        
        chartView.xAxis.drawGridLinesEnabled = false // 不繪製 Ｘ 軸延伸格線
        chartView.xAxis.avoidFirstLastClippingEnabled = true // X 軸文字起始不貼齊 Y 軸
        chartView.leftAxis.drawGridLinesEnabled = false //不繪製 Y 軸延伸格線
        chartView.rightAxis.enabled = false //禁用右侧的Y轴
        
        chartView.xAxis.labelPosition = .bottom // x 軸文字顯示位置
        chartView.xAxis.axisMaximum = 5 // 最大刻度
        chartView.xAxis.axisMinimum = 0 // 最小刻度
        chartView.xAxis.granularity = 1 // 最小間隔
        chartView.leftAxis.granularity = 1 // 最小間隔
        chartView.leftAxis.axisMaximum = 6 // 最大刻度
        chartView.leftAxis.axisMinimum = 0 // 最小刻度
        
        // 自定義刻度文字
        let defaultXValues =  ["1", "2", "3", "4", "5", "6"]
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues ?? defaultXValues)
        if let yValues = yValues {
            chartView.leftAxis.valueFormatter = IndexAxisValueFormatter(values: yValues)
        }
    }
     
    func setupData(entries: [ChartDataEntry]?, label: String = "") {
       
        //設定數據資料來源
        let chartDataSet = LineChartDataSet(entries: entries ?? [], label: label )
        
        chartDataSet.colors = [.orange] // 折線顏色
        chartDataSet.circleColors = [.orange] // 折點外圓顏色
        chartDataSet.circleHoleColor = .white //折點內圓顏色
        
        chartDataSet.mode = .horizontalBezier //折線圖樣式
        
        chartDataSet.valueColors = [.brown] // 折點文字顏色
        chartDataSet.valueFont = .systemFont(ofSize: 9) // 折點文字樣式大小
        
        chartDataSet.drawFilledEnabled = true //填充顏色
        //漸層色
        let gradientColors = [UIColor.orange.cgColor, UIColor.white.cgColor] as CFArray
        //每組顏色所在位置（範圍0~1)
        let colorLocations: [CGFloat] = [1.0, 0.0]
        //產生漸層色
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: gradientColors, locations: colorLocations)
        //設定漸層色為填充色
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        chartDataSet.fillAlpha = 0.5 //填充色透明度
        
        chartDataSet.highlightEnabled = false  // 不顯示十字線
        
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        chartData.setValueFormatter(MyFormatter())
        //設置折線圖數據
        chartView.data = chartData
    }
    
    func notifyDataChanged() {
        // 改變資料、樣式要呼叫的方法
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
}

class MyFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry,
                        dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        let string = "\(formatter.string(from: NSNumber(value: value * 10)) ?? "") kg"
        
        return string
    }
}

extension PNChartView: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        delegate?.chartValueSelected()
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        delegate?.chartValueNothingSelected()
    }
}

protocol PNChartViewDelegate: AnyObject {
    func chartValueSelected()
    func chartValueNothingSelected()
}
