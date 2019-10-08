//
//  SwitchPetView.swift
//  PetNote
//
//  Created by iching chen on 2019/9/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol SwitchPetViewDelegate: UICollectionViewDelegate, UICollectionViewDataSource, AnyObject {
//    func changePet(_ indexPath: IndexPath)
//    func addPet()
}

class SwitchPetView: UIView {
    
    var collectionView: UICollectionView! {

        didSet {

            collectionView.dataSource = self.delegate
            collectionView.delegate = self.delegate
            
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    let minCollectionViewSpacing = 0
    
    weak var delegate: SwitchPetViewDelegate? {
        didSet {
            collectionView.dataSource = self.delegate
            collectionView.delegate = self.delegate
        }
    }
    
    let storageManager = StorageManager.shared
    
    var pets: [PNPetInfo] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        setupCollectionViewCell()
    }
    
    class func instanceFromNib() -> UIView? {
        
        return UINib(nibName: "SwitchPetView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setupCollectionView()
        setupCollectionViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
        setupCollectionViewCell()
    }
    
    private func setupCollectionViewCell() {
        collectionView.registerCellWithNib(
            identifier: String(describing: PetsCollectionViewCell.self),
            bundle: nil
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard
            let layout = collectionView.collectionViewLayout
            as? UICollectionViewFlowLayout
        else { return }

        layout.itemSize = CGSize(
            width: frame.width / 4,
            height: frame.height
        )
    }
    
    private func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
     
        layout.minimumLineSpacing = CGFloat(integerLiteral: minCollectionViewSpacing)
        // 滑動方向為「垂直」的話即「上下」的間距;
//        滑動方向為「平行」則為「左右」的間距
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: minCollectionViewSpacing)
        // 滑動方向為「垂直」的話即「左右」的間距;
//        滑動方向為「平行」則為「上下」的間距
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal //滑動方向預設為垂直。注意若設為垂直，則 cell 的加入方式為由左至右，
//        滿了才會換行；若是水平則由上往下，滿了才會換列
        
        collectionView = UICollectionView(
            frame: CGRect(origin: CGPoint.zero,
                          size: CGSize.zero),
            collectionViewLayout: layout)
        
        self.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: self.topAnchor),
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
//        collectionView(self.collectionView, didSelectItemAt: IndexPath(row: 0, section: 1))
    }
    
    func fetchData() {
        storageManager.fetchPets(completion: { [weak self] result in
            switch result {
            case .success(let pets):
                self?.pets = pets
            case .failure:
                print("寵物資料讀取失敗")
            }
        })
    }
    
    func updatePetsData(pets: [PNPetInfo]) {
        self.pets = pets
    }
    
    func updatePetsData() {
        collectionView.reloadData()
    }
    
    func updateSelectedStatus() {
        for cell in collectionView.visibleCells {
            guard
                let cell = cell as? PetsCollectionViewCell
            else {
                    return
            }
            cell.changeSlectedStatus()
        }
    }
    
    func updateSelectedStatus(indexPath: IndexPath, isSelected: Bool) {
        
        guard
            let cell = collectionView.cellForItem(at: indexPath)
                as? PetsCollectionViewCell
        else {
            return
        }
        cell.changeSlectedStatus(isSelected)
    }
}
