//
//  AdjustPhotoViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/10/2.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class AdjustPhotoViewController: BaseViewController {
    
    @IBOutlet weak var visibleView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    
    var imageView: UIImageView = UIImageView()
    
    var targetPhoto: UIImage? {
        didSet {
            imageView.image = targetPhoto
        }
    }
    
    var completeAdjustPhotoHandler: ((UIImage) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "選擇照片顯示範圍"
        setupVisibleImageView()
    }
    
    override func viewDidLayoutSubviews() {
        setupScrollViewContentView()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    override func navigationBarSetting() {
        super.navigationBarSetting()
        
        let saveButton = UIBarButtonItem(
            title: "確定",
            style: .plain,
            target: self,
            action: #selector(confirmSnapShot)
        )
        
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupVisibleImageView() {
        scrollView.addSubview(imageView)
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
    
    func setupScrollViewContentView() {
        scrollView.frame = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: visibleView.frame.size
        )
        
        imageView.frame = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: visibleView.frame.size
        )
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        let maxScale = max(size.width, size.height)
        
        scrollView.maximumZoomScale = maxScale
        scrollView.zoomScale = minScale
        
    }
    
    func initAdjustPhotoVC(image: UIImage, handler: @escaping ((UIImage) -> Void)) {
        
        targetPhoto = image
        completeAdjustPhotoHandler = handler
        
        imageView.image = image
        
    }
    
    @objc func confirmSnapShot() {
        
        let image = visibleView.takeSnapshot()
        completeAdjustPhotoHandler?(image)
        
        navigationController?.popToRootViewController(animated: false)
    }
}

extension AdjustPhotoViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
        
    }
    
}
