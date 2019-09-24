//
//  WeightRecordViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/3.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import Charts

class WeightRecordViewController: BaseContainerViewController {

//    @IBOutlet weak var switchPetLayer: UIView! {
//        didSet {
//            switchPetLayer.addSubview(switchPetView)
//        }
//    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    func petDidChange() {
        guard let pet = currentPet,
            let weights = pet.weightRecord?.sortedArray(using: [NSSortDescriptor(key: "date", ascending: false)])
                as? [PNWeightRecord] else { return }
        self.weights = weights
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    var weights: [PNWeightRecord] = [] {
        didSet {
            weights.sort(by: >)
            tableView.reloadData()
        }
    }
    
    var recordDates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "體重記錄"
//        switchPetView.delegate = self
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: ChartTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: WeightLabelTableViewCell.self), bundle: nil)
    }
    
    func getWeightDataEntry() -> [ChartDataEntry] {
        
        var dataEntries = [ChartDataEntry]()
        
        var index = 0
        recordDates = []
        
        for weightRecord in weights {
            
            let date = Int(weightRecord.date).getDateString(format: "MM/dd")
            recordDates.append(date)
            let weight = weightRecord.weight
            let entry =
                ChartDataEntry.init(x: Double(index), y: weight)
            dataEntries.append(entry)
            index += 1
            if index == 6 {
                break
            }
        }
        
        return dataEntries
    }
}

extension WeightRecordViewController: UITableViewDelegate {
    
}

extension WeightRecordViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return weights.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ChartTableViewCell.self),
                    for: indexPath)
                as? ChartTableViewCell
            else {
                    return UITableViewCell()
            }
            cell.delegate = self
            let chartViewFrame = CGRect(x: 0, y: 0,
                                        width: cell.chartLayer.frame.width,
                                        height: cell.chartLayer.frame.height)
            let chartView = PNChartView(chartViewFrame)
            chartView.setup()
            
            chartView.setupData(entries: getWeightDataEntry(), label: "")
            chartView.setupAxis(xValues: recordDates)
            
            cell.chartLayer.subviews.forEach { $0.removeFromSuperview() }
            cell.chartLayer.addSubview(chartView)
            return cell
            
        } else {
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: WeightLabelTableViewCell.self),
                    for: indexPath)
                    as? WeightLabelTableViewCell
            else {
                    return UITableViewCell()
            }
            let date = Int(weights[indexPath.row].date).getDateString()
            let weight = String(weights[indexPath.row].weight)
            cell.layoutCell(date: date, weight: weight)
            
            return cell
            
        }
        
    }
    
}

extension WeightRecordViewController: ChartTableViewCellDelegate {
    func addWeightRecord(date: Int, weight: Double) {
        let weightRecord = StorageManager.shared.getPNPNWeightRecord()
        weightRecord.date = Int64(date)
        weightRecord.weight = weight
        
        guard currentPet != nil else { return }
        currentPet?.addToWeightRecord(weightRecord)
        
        StorageManager.shared.saveAll {[weak self] result in
            switch result {
            case .success:
                self?.weights.append(weightRecord)
                self?.tableView.reloadData()
                print("成功加入體重")
            case .failure(let error):
                print(error)
            }
        }
    }
}
