//
//  WebViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/9/26.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    
    @IBOutlet weak var aboutWebView: WKWebView! {
        didSet {
            aboutWebView.navigationDelegate = self
        }
    }
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "隱私權政策"
        showInfo()
    }
   
    func showInfo() {
        
        guard let link = urlString else {return}
        
        if let url = URL(string: link) {
            let request = URLRequest(url: url)
            
            aboutWebView.load(request)
        }
        
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
}
