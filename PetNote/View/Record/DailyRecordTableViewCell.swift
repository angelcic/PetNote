//
//  DailyRecordTableViewCell.swift
//  PetNote
//
//  Created by iching chen on 2019/9/24.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class DailyRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var eventCollectionView: UICollectionView! {
        didSet {
            eventCollectionView.delegate = self
            eventCollectionView.dataSource = self
        }
    }
    
    var events: [String] = [] {
        didSet {
            eventCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        // Initialization code
    }
    
    func setupCollectionView() {
        eventCollectionView.registerCellWithNib(identifier: EventCollectionViewCell.identifier, bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layoutCell(date: Date, describe: String?, events: [String]?) {
        dateLabel.text = date.getDateString()
        descriptionLabel.text = describe
        self.events = events ?? []
    }
    
}
extension DailyRecordTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4, height: 20)
    }
}

extension DailyRecordTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath)
            as? EventCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.layoutCell(title: events[indexPath.row])
        
        return cell
    }
        
}
