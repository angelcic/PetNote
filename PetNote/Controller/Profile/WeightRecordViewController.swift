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

    @IBOutlet weak var switchPetLayer: UIView! {
        didSet {
            switchPetLayer.addSubview(switchPetView)
        }
    }
        
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let weights: [Double] = [4.5, 4.6, 5.0, 4.8]
    
    var switchPetView: SwitchPetView = SwitchPetView(frame: CGRect.zero) {
        didSet {
            switchPetView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "體重記錄"
        
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPetSwitchLayer()

    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: ChartTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: WeightLabelTableViewCell.self), bundle: nil)
    }

    func setupPetSwitchLayer() {
        switchPetView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: switchPetLayer.frame.size)
        
    }
}

extension WeightRecordViewController: SwitchPetViewDelegate {
    func changePet(_ indexPath: IndexPath) {
        // TODO:
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
            
            let chartViewFrame = CGRect(x: 0, y: 0,
                                        width: cell.chartLayer.frame.width,
                                        height: cell.chartLayer.frame.height)
            let chartView = PNChartView(chartViewFrame)
                chartView.setup()
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
            
            return cell        }
        
    }
    
}
