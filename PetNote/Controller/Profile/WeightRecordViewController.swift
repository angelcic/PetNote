//
//  WeightRecordViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/3.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import Charts

class WeightRecordViewController: SwitchPetViewController, SwitchPetViewControllerProtocol {

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
    
    var currentPet: PNPetInfo? {
        didSet {
            guard let pet = currentPet,
            let weights = pet.weightRecord?.allObjects as? [PNWeightRecord] else { return }
            self.weights = weights
        }
    }
    
    var weights: [PNWeightRecord] = []
    
//    var switchPetView = SwitchPetView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "體重記錄"
        switchPetView.delegate = self
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setupPetSwitchLayer()

    }
    
    func setupTableView() {
        tableView.registerCellWithNib(identifier: String(describing: ChartTableViewCell.self), bundle: nil)
        tableView.registerCellWithNib(identifier: String(describing: WeightLabelTableViewCell.self), bundle: nil)
    }

    func setupPetSwitchLayer() {
        switchPetView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: switchPetLayer.frame.size)
        
    }
    
    // MARK: switchPetView function
    func changePet(_ indexPath: IndexPath) {
        // TODO:
    }
    
    func updateSwitchView() {
        switchPetView.updatePetsData()
    }
    
    func getWeightDataEntry() -> [ChartDataEntry] {
        
        var dataEntries = [ChartDataEntry]()
        
        weights.forEach() {
            
            let date = Int(Int($0.date).getDateString(format: "dd"))
            let weight = $0.weight
            let entry =
            ChartDataEntry.init(x: Double(date ?? 0), y: weight)
            dataEntries.append(entry)
        }
        
        return dataEntries
//        for index in 0..<5 {
//            //            let y = arc4random()%100
//            let yyy = Double.random(in: 0...6)
//            let entry = ChartDataEntry.init(x: Double(index), y: Double(yyy))
//            dataEntries.append(entry)
//        }
    }
}

//extension WeightRecordViewController: SwitchPetViewDelegate {
//    
//}

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
            
//            let month = Int(weights[weights.count - 1].date).getDateString(format: "MM")
            
            chartView.setupData(entries: getWeightDataEntry() , label: "")
            
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
            let weight = String(weights[indexPath.row].date)
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
        
        currentPet?.addToWeightRecord(weightRecord)
        
        StorageManager.shared.saveAll {[weak self] result in
            switch result {
            case .success:
//                self?.protectPlans.append(weightRecord)
                self?.tableView.reloadData()
                print("成功加入體重")
            case .failure(let error):
                print(error)
            }
        }
    }
}
