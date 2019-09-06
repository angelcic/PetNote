//
//  SwitchPetView.swift
//  PetNote
//
//  Created by iching chen on 2019/9/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
protocol SwitchPetViewDelegate: AnyObject {
    func changePet(_ indexPath: IndexPath)
}

class SwitchPetView: UIView {
    
    var collectionView: UICollectionView! {

        didSet {

            collectionView.dataSource = self

            collectionView.delegate = self
        }
    }
    
    weak var delegate: SwitchPetViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()

    }
    

    
    class func instanceFromNib() -> UIView? {
//        let nib = UINib(nibName: "SwitchPetView", bundle: nil)
//        let instantArray = nib.instantiate(withOwner: nil, options: nil)
//        let switchPetView = instantArray[0]
        
        return UINib(nibName: "SwitchPetView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self
        fatalError("init(coder:) has not been implemented")
//        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.registerCellWithNib(
            identifier: String(describing: PetsCollectionViewCell.self),
            bundle: nil
        )
    }
    
    private func setupCollectionView(frame: CGRect) {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        print(frame)
         print("===========")
        layout.itemSize = CGSize(width: frame.width / 4, height: frame.height) // cell的寬、高
        layout.minimumLineSpacing = CGFloat(integerLiteral: 10) // 滑動方向為「垂直」的話即「上下」的間距;滑動方向為「平行」則為「左右」的間距
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 6) // 滑動方向為「垂直」的話即「左右」的間距;滑動方向為「平行」則為「上下」的間距
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal // 滑動方向預設為垂直。注意若設為垂直，則cell的加入方式為由左至右，滿了才會換行；若是水平則由上往下，滿了才會換列
        
        collectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size), collectionViewLayout: layout)
//        (x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: self.topAnchor),
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension SwitchPetView: UICollectionViewDelegateFlowLayout {
   
}

extension SwitchPetView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.changePet(indexPath)
    }
}

extension SwitchPetView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetsCollectionViewCell.identifier, for: indexPath) as? PetsCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        return cell
    }
}
