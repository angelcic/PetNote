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
    
    @IBOutlet weak var selectionViewLayer: UIView!
//    {
//        didSet {
//            let selectionView = SelectionView(CGRect(x: 0, y: 0, width: selectionViewLayer.frame.width, height: selectionViewLayer.frame.height))
//
//            selectionView.delegate = self
//            selectionView.dataSource = self
//
//            selectionView.backgroundColor = .white
//            selectionViewLayer.addSubview(selectionView)
//        }
//    }
    
//    @IBOutlet weak var collectionView: UICollectionView! {
//
//        didSet {
//
//            collectionView.dataSource = self.delegate
//
//            collectionView.delegate = self.delegate
//        }
//    }
    
    @IBOutlet weak var basicInfoContainerView: UIView!
    @IBOutlet weak var protectPlanContainerView: UIView!
    @IBOutlet weak var healthRecordContainerView: UIView!
    
    var containerViews: [UIView] {
        
        return [basicInfoContainerView, protectPlanContainerView, healthRecordContainerView]
    }
    
    weak var delegate: ProfileDetailViewDelegate?
//        {
//
//        didSet {
//
//            guard let collectionView = collectionView else { return }
//
//            collectionView.dataSource = self.delegate
//
//            collectionView.delegate = self.delegate
//        }
//    }
    
//    let page = ["基本資料", "預防計畫", "健康記錄"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        setupCollectionView()
    }

//    private func setupCollectionView() {
//        let selectionView = SelectionView(
//            CGRect(x: 0,
//                   y: 0,
//                   width: selectionViewLayer.frame.width,
//                   height: selectionViewLayer.frame.height))
//
//        selectionView.delegate = self
//        selectionView.dataSource = self
//
//        selectionView.backgroundColor = .white
//        selectionViewLayer.addSubview(selectionView)
//
//    }

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
        
        selectionView.backgroundColor = .clear
        selectionViewLayer.addSubview(selectionView)
        
//        collectionView.registerCellWithNib(
//            identifier: String(describing: PetsCollectionViewCell.self),
//            bundle: nil
//        )
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

extension ProfileDetailView: SelectionViewDelegate {
    func didSelectAt(_ selectView: SelectionView, index: Int) {
        
        guard let type = PageType(rawValue: index) else {
            return
        }
        updateContainer(type: type)
    }
    
    func updateSwitchView() {
    //        switchPetView.updatePetsData()
    }
}

extension ProfileDetailView: SelectionViewDataSource {
    
    var page: [String] {
        
        return ["基本資料", "預防計畫", "健康記錄"]
        
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
        button.setTitle(page[index], for: .normal)
    }
}
