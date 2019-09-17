//
//  BaseSwitchPetViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/14.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol SwitchPetViewControllerProtocol {
    func changePet(_ indexPath: IndexPath)
    func updateSwitchView()
}

typealias BaseSwitchPetViewController = SwitchPetViewController & SwitchPetViewControllerProtocol

class SwitchPetViewController: BaseViewController {
 
    let storageManager = StorageManager.shared
    
//    var currentPetIndex = 0
    
    var observer: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observer = storageManager.observe(\.currentPetIndex, options: [.new, .initial]) {[weak self] (object, change) in
            print(change)
            
            guard let controller = self as? BaseSwitchPetViewController else {
                return
            }
            controller.updateSwitchView()
        }
        
    }
    
    func showAddPetVC() {
        guard let addPetVC = UIStoryboard.profile.instantiateViewController(
            withIdentifier: AddPetViewController.identifier)
            as? AddPetViewController
            else {return}
        
        addPetVC.delegate = self
        
        // 顯示樣式
        addPetVC.modalPresentationStyle = UIModalPresentationStyle.custom
        
        self.present(addPetVC, animated: false, completion: nil)
        
        addPetVC.view.backgroundColor = UIColor.clear
    }
}

// 顯示加入成員是否成功，若成功應更新寵物列表
extension SwitchPetViewController: AddPetViewControllerDelegate {
    func addPetResult(_ result: Result<Int, Error>) {
        switch result {
        case .success:
            
            guard let controller = self as? BaseSwitchPetViewController else {
                return
            }
            controller.updateSwitchView()
            
        case .failure(let error) :
            print(error)
        }
    }
}

extension SwitchPetViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        for cell in collectionView.visibleCells {
//            guard
//                let cell = cell as? PetsCollectionViewCell
//                else {
//                    return
//            }
//            cell.changeSlectedStatus()
//        }
        
        switch indexPath.section {
        case 0:
            showAddPetVC()
        default :
            for cell in collectionView.visibleCells {
                guard
                    let cell = cell as? PetsCollectionViewCell
                    else {
                        return
                }
                cell.changeSlectedStatus()
            }
//            guard
//                let cell = collectionView.cellForItem(at: indexPath)
//                    as? PetsCollectionViewCell
//            else {
//                return
//            }
//            cell.changeSlectedStatus(true)
            storageManager.currentPetIndex = indexPath.row
            
            guard let controller = self as? BaseSwitchPetViewController else {
                return
            }
            controller.changePet(indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        guard
//            let cell = collectionView.cellForItem(at: indexPath)
//                as? PetsCollectionViewCell
//            else {
//                return
//        }
//        cell.changeSlectedStatus(false)
    }
    
}

extension SwitchPetViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
//            return 0
            return 1
        } else {
            //            return 5
            return storageManager.petsList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PetsCollectionViewCell.identifier,
            for: indexPath)
            as? PetsCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        
        if indexPath.section == 0 {
            cell.layoutCell(image: UIImage(named: "Icons_24px_Add01"), name: "新增")
            cell.petImageView.contentMode = .center
            cell.petImageBorderView.isHidden = true
        } else {
            cell.isSelected = false
            cell.changeSlectedStatus()
            
            if indexPath.row ==                storageManager.currentPetIndex {
//            PNGlobalProperties.currentPetIndex {
//                cell.isSelected = true
                cell.changeSlectedStatus(true)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//                cell.petImageBorderView.isHidden = false
            }
           
            cell.layoutCell(image: nil, name: storageManager.petsList[indexPath.row].name)
            
        }
        
        return cell
    }
}
