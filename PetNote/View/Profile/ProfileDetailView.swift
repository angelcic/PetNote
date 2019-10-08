//
//  ProfileDetailView.swift
//  PetNote
//
//  Created by iching chen on 2019/8/30.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

enum PageType: Int {
    
    case basicInfo = 0
    
    case protectPlan = 1
    
    case healthRecord = 2
    
    var pageTitle: String {
        switch self {
        case .basicInfo:
            return "基本資料"
        case .protectPlan:
            return "預防計畫"
        case .healthRecord:
            return "體重記錄"
        }
    }
}

class ProfileDetailView: UIView {
    
    //  container view 切換條
    @IBOutlet weak var selectionViewLayer: UIView!
    
    @IBOutlet weak var basicInfoContainerView: UIView!
    @IBOutlet weak var protectPlanContainerView: UIView!
    @IBOutlet weak var healthRecordContainerView: UIView!
    
    // 無寵物成員提示，無成員時阻擋其他操作
    @IBOutlet weak var addPetAlertLayer: UIView!
    
    let selectionView = SelectionView(CGRect.zero)
    
    var containerViews: [UIView] {
        
        return [basicInfoContainerView,
                protectPlanContainerView,
                healthRecordContainerView]
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSelectionView()
        self.backgroundColor = .white
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        resetSelectionViewFrame()
    }
    
    private func setupSelectionView() {
        
        selectionView.delegate = self
        selectionView.dataSource = self
        
        selectionView.backgroundColor = .clear
        selectionViewLayer.addSubview(selectionView)
        
    }
    
    // 更新切換頁面條介面大小
    private func resetSelectionViewFrame() {
        
        selectionView.setupFrame(
            CGRect(x: 0,
                   y: 0,
                   width: selectionViewLayer.frame.width,
                   height: selectionViewLayer.frame.height)
        )
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
    
    func changeAddPetAlertStatus(isHidden: Bool) {
        
        addPetAlertLayer.isHidden = isHidden
        
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
    
    var page: [PageType] {

        return [.basicInfo, .protectPlan, .healthRecord]

    }
    
    func indicatorColor() -> UIColor {
        return (UIColor.pnBlueDark)!
    }
    
    func textColor() -> UIColor {
        return (UIColor.pnBlueDark)!
    }
    
    func buttonBackgroundColor() -> UIColor {
        return .clear
    }
    
    func numberOfSelectBTN(_ selectView: SelectionView) -> Int {
        return page.count
    }
    
    func buttonForRowAt(_ selectView: SelectionView, index: Int, button: UIButton) {
        button.setTitle(page[index].pageTitle, for: .normal)
    }
}
