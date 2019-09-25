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
    func petsNumberChange(isEmpty: Bool)
}

typealias BaseSwitchPetViewController = SwitchPetViewController & SwitchPetViewControllerProtocol

class SwitchPetViewController: BaseViewController, SwitchPetViewDelegate {
 
    @IBOutlet weak var switchPetView: SwitchPetView! {
        didSet {
            switchPetView.delegate = self
        }
    }
    
    let storageManager = StorageManager.shared
    
    var petIndexObserver: NSKeyValueObservation!
    var petListObserver: NSKeyValueObservation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPetIndexObserver()
        setupPetArrayObserver()
        
    }
    
    func setupPetIndexObserver() {
        petIndexObserver =
            storageManager.observe(\.currentPetIndex, options: [.old, .new]) {[weak self] (object, change) in
                
                guard let switchPetView = self?.switchPetView else { return }
                //            switchPetView.updatePetsData()
                //            print(change)
                
                if let oldValue = change.oldValue {
                    let indexPath = IndexPath(row: oldValue, section: 1)
                    switchPetView.updateSelectedStatus(indexPath: indexPath, isSelected: false)
                }
                
                if let newValue = change.newValue {
                    let indexPath = IndexPath(row: newValue, section: 1)
                    switchPetView.updateSelectedStatus(indexPath: indexPath, isSelected: true)
//                    guard let cell = switchPetView.collectionView.cellForItem(at: indexPath) else {return}
                    switchPetView.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    guard let controller = self as? BaseSwitchPetViewController else {
                        return
                    }
                    controller.changePet(indexPath)
                }
        }
    }
    
    func setupPetArrayObserver() {
        petListObserver = storageManager.observe(\.datas, options: [.initial, .new]) {[weak self] (object, change) in
            
            guard
                let switchPetView = self?.switchPetView
            else { return }
            switchPetView.updatePetsData()            
            
            guard
                let controller = self as? BaseSwitchPetViewController
            else { return }
            
            if self?.storageManager.datas.count == 0 {
                controller.petsNumberChange(isEmpty: true)
            } else {
                controller.petsNumberChange(isEmpty: false)
            }
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
            print("新增success")
            storageManager.currentPetIndex = storageManager.petsList.count - 1
            
        case .failure(let error) :
            print(error)
        }
    }
}

extension SwitchPetViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            showAddPetVC()
        default :
            
            storageManager.currentPetIndex = indexPath.row
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
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
            cell.changeSlectedStatus(false)
            cell.layoutCell(image: UIImage(named: "Icons_24px_Add01"), name: "新增")
            cell.petImageView.contentMode = .center
//            cell.petImageBorderView.isHidden = true
        } else {
            cell.changeSlectedStatus(false)
            cell.isSelected = false
            cell.changeSlectedStatus()
            
            if indexPath.row == storageManager.currentPetIndex {
//            PNGlobalProperties.currentPetIndex {
//                cell.isSelected = true
                cell.changeSlectedStatus(true)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//                cell.petImageBorderView.isHidden = false
            }
            
            let image =
                LocalFileManager.shared.readImage(imagePath: storageManager.petsList[indexPath.row].photo)
            
            cell.petPhotoObserver = nil
            cell.petPhotoObserver =
                storageManager.petsList[indexPath.row].observe(\.photo, options: [.new]) { (object, change) in

                guard let newValue = change.newValue else { return }
                //                print(change)
                let image = LocalFileManager.shared.readImage(imagePath: newValue)
                    
                cell.petImageView.image = image
            }
                
            cell.layoutCell(image: image, name: storageManager.petsList[indexPath.row].name)
            
        }
        
//        cell.petNameObserver = nil
//        cell.petNameObserver =
//            storageManager.petsList[indexPath.row].observe(\.name, options: [.new]) { (object, change) in
//                
//                cell.nameLabel.text = change.newValue
//        }

        
        return cell
    }
}
