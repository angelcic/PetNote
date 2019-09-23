//
//  ProfileDetailView.swift
//  PetNote
//
//  Created by iching chen on 2019/8/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol ProfileDetailViewDelegate: SwitchPetViewDelegate, NSObject {
    
}

class ProfileDetailView: UIView {
    
    private enum PageType: Int {
        
        case basicInfo = 0
        
        case protectPlan = 1
        
        case healthRecord = 2
    }
    
    @IBOutlet weak var basicInfoContainerView: UIView!
    @IBOutlet weak var protectPlanContainerView: UIView!
    @IBOutlet weak var healthRecordContainerView: UIView!
    
    @IBOutlet weak var selectionViewLayer: UIView!
    
    var containerViews: [UIView] {
        
        return [basicInfoContainerView, protectPlanContainerView, healthRecordContainerView]
    }
    
    weak var delegate: ProfileDetailViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        setupPetSwitchLayer()
        setupSelectionView()
    }
    
    // 更新切換頁面條介面大小
    private func setupSelectionView() {
        
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
    
    // MARK: 切換分頁
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
    
    // 更新分頁按鈕狀態
    func updateSwitchView() {
//        switchPetView.updatePetsData()
    }
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
    
    var page: [String] {
        
        return ["基本資料", "預防計畫", "健康記錄"]
        
    }
    
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
