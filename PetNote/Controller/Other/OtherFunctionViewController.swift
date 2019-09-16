//
//  OtherFunctionViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/7.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class OtherFunctionViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    enum FunctionType: Int {
        case hospital = 0
        case alert = 1
        
        func getFunctionVC() -> UIViewController? {
            switch self {
            case .hospital:
                return UIStoryboard.other.instantiateViewController(
                    withIdentifier: String(describing: SearchHospitalViewController.self))
                    as? SearchHospitalViewController
            case .alert:
                return UIStoryboard.other.instantiateViewController(
                    withIdentifier: String(describing: NotificationManageViewController.self))
                    as? NotificationManageViewController
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView() {
        collectionView.registerCellWithNib(identifier: String(describing: BasicCollectionViewCell.self), bundle: nil)
    }
    
    func showfunctionPage(_ type: FunctionType) {
        
//        guard  let functionVC = UIStoryboard.other.instantiateViewController(
//        withIdentifier: String(
//        describing: SearchHospitalViewController.self)) as? SearchHospitalViewController
        guard
            let functionVC = type.getFunctionVC()
        else {
            return
        }
        
        show(functionVC, sender: nil)
    }
    
}

extension OtherFunctionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let functinType = FunctionType.init(rawValue: indexPath.row) else { return }
        showfunctionPage(functinType)
    }
}

extension OtherFunctionViewController: UICollectionViewDelegateFlowLayout {
    
    var screenWidth: CGFloat {
        return UIScreen.width
    }
    
    var spacing: CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - spacing) / 2
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension OtherFunctionViewController: UICollectionViewDataSource {
    var functions: [String] {
        return ["附近醫院", "通知管理", "保健知識", "設定", "計算機幫手", "備份"]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return functions.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BasicCollectionViewCell.self), for: indexPath)
        as? BasicCollectionViewCell
            else {
                return BasicCollectionViewCell()
        }
        cell.layoutCell(title: functions[indexPath.row])
        return cell
    }
    
}