//
//  RecordViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import FSCalendar

class RecordViewController: SwitchPetViewController, SwitchPetViewControllerProtocol {
    
    @IBOutlet weak var switchPetLayer: UIView! {
        didSet {
            switchPetLayer.addSubview(switchPetView)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton! {
        didSet {
            addButton.addCorner(cornerRadius: 30)
        }
    }
    
    @IBOutlet weak var calendar: FSCalendar! {
        didSet {
            calendar.dataSource = self
            calendar.delegate = self
//            calendar.backgroundColor = .pnWhite            
        }
    }
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
//    var switchPetView = SwitchPetView()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar,
                                                action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        switchPetView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setupSwitchPetView()
    }
    
    func setCalendar() {
// 加入上滑月曆縮小功能
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
    }
    
    func setupSwitchPetView() {
        switchPetView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: switchPetLayer.frame.size)
    }
    
    func changePet(_ indexPath: IndexPath) {
        // TODO:
    }
    
    func updateSwitchView() {
        switchPetView.updatePetsData()
    }
    
    @IBAction func addAction(_ sender: Any) {
        guard let addRecordVC = UIStoryboard.record.instantiateViewController(
            withIdentifier: String(describing: AddRecordViewController.self))
            as? AddRecordViewController else { return }
        show(addRecordVC, sender: nil)
    }
}

//extension RecordViewController: SwitchPetViewDelegate {
//    func changePet(_ indexPath: IndexPath) {
//        
//    }
//}

extension RecordViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            default:
                return false
            }
        }
        return shouldBegin
    }
}

extension RecordViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
}

extension RecordViewController: FSCalendarDataSource {
    
}
