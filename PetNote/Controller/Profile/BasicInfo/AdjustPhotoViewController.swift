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
        
        setupScrollViewContentView()
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
        
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        scrollView.addSubview(imageView)
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
    
    override func viewWillLayoutSubviews() {
        
        updateMinZoomScaleForSize(view.bounds.size)
        
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
