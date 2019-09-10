//
//  ProfileDetailView.swift
//  PetNote
//
//  Created by iching chen on 2019/8/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ProfileDetailView: UIView {
    
    private enum PageType: Int {
        
        case basicInfo = 0
        
        case protectPlan = 1
        
        case healthRecord = 2
    }
    
    @IBOutlet weak var selectionViewLayer: UIView! {
        didSet {
            let selectionView = SelectionView(
                CGRect(x: 0,
                       y: 0,
                       width: selectionViewLayer.frame.width,
                       height: selectionViewLayer.frame.height))
            
            selectionView.delegate = self
            selectionView.dataSource = self

            selectionView.backgroundColor = .white
            selectionViewLayer.addSubview(selectionView)
        }
    }
    
    @IBOutlet weak var basicInfoContainerView: UIView!
    @IBOutlet weak var protectPlanContainerView: UIView!
    @IBOutlet weak var healthRecordContainerView: UIView!
    
    @IBOutlet weak var userSwitchLayer: UIView!
    
    weak var switchPetView: SwitchPetView! {
        didSet {
            switchPetView.delegate = self.delegate
        }
    }
    
    var containerViews: [UIView] {
        
        return [basicInfoContainerView, protectPlanContainerView, healthRecordContainerView]
    }
    
    weak var delegate: ProfileDetailViewDelegate? {
        
        didSet {
            
            if let switchPetView = switchPetView {
                switchPetView.delegate = self.delegate
            }
        }
    }
    
    let page = ["基本資料", "預防計畫", "健康記錄"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPetSwitchLayer()
//        setupCollectionView()
    }
    
    private func setupPetSwitchLayer() {
        let switchPetView = SwitchPetView(
                frame: CGRect(x: 0, y: 0,
                              width: userSwitchLayer.frame.width,
                              height: userSwitchLayer.frame.height))
//        guard let switchPetView = SwitchPetView.instanceFromNib() as? SwitchPetView else {return}
        self.switchPetView = switchPetView
        userSwitchLayer.addSubview(self.switchPetView)
    }
    
    private func updateContainer(type: PageType) {
        
        containerViews.forEach({ $0.isHidden = true })
        
        switch type {
            
        case .basicInfo:
            basicInfoContainerView.isHidden = false
            
        case .protectPlan:
            protectPlanContainerView.isHidden = false
            
        case .healthRecord:
            healthRecordContainerView.isHidden = false
            
        }
    }
}

protocol ProfileDetailViewDelegate: UICollectionViewDelegate, UICollectionViewDataSource, SwitchPetViewDelegate {
    
}

extension ProfileDetailView: SelectionViewDelegate {
    func didSelectAt(_ selectView: SelectionView, index: Int) {
        
        guard let type = PageType(rawValue: index) else {
            return
        }
        updateContainer(type: type)
    }
}

extension ProfileDetailView: SelectionViewDataSource {
    
    func indicatorColor() -> UIColor {
        return .gray
    }
    
    func textColor() -> UIColor {
        return .gray
    }
    
    func buttonBackgroundColor() -> UIColor {
        return .white
    }
    
    func numberOfSelectBTN(_ selectView: SelectionView) -> Int {
        return page.count
    }
    
    func buttonForRowAt(_ selectView: SelectionView, index: Int, button: UIButton) {
        button.setTitle(page[index], for: .normal)
    }
}
