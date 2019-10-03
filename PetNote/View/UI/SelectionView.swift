//
//  SelectionBarView.swift
//  PetNote
//
//  Created by iching chen on 2019/8/29.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

class SelectionView: UIView {
    var dataSource: SelectionViewDataSource? {
        didSet {
            setUp()
        }
    }
    
    weak var delegate: SelectionViewDelegate?
    
    // 使用者決定要幾個 BTN
    var buttonNumber = 0
    var buttonArray: [UIButton] = []
    
    var currentSelectedIndex = 0 // 現在被選擇的 button
    
    let stackView = UIStackView()
    let IndicatorView = UIView()
    
    init(_ rect: CGRect) {
        super.init(frame: rect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // datasource 被設定才會開始 setup
    func setUp() {
        // 設定要顯示的 button 數量、樣式
        buttonArray = initSelectBTN()
        
        // 設定 stackView 大小、樣式
//        let stackView = UIStackView(arrangedSubviews: buttonArray)
        buttonArray.forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.distribution = .fillEqually
        stackView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        stackView.axis = .horizontal
        
        IndicatorView.frame = CGRect(x: 0, y: self.frame.height - 3, width: self.frame.width / CGFloat(buttonNumber), height: 2)
        IndicatorView.backgroundColor = dataSource?.indicatorColor()
        
        self.addSubview(stackView)
        self.addSubview(IndicatorView)
    }
    
    func setupFrame(_ rect: CGRect) {
        self.frame = rect
        stackView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        IndicatorView.frame = CGRect(x: 0, y: self.frame.height - 3, width: self.frame.width / CGFloat(buttonNumber), height: 2)
    }
    
    // 依據 datasource 創建 button
    func initSelectBTN() -> [UIButton] {
        
        guard let dataSource = dataSource else {
            return []
        }
        
        var customButtons: [UIButton] = []
        buttonNumber = dataSource.numberOfSelectBTN(self)
        
        for index in 0...buttonNumber - 1 {
            let button = UIButton()
            // 預設的 button 外觀
            button.setTitleColor(dataSource.textColor(), for: .normal)
            button.backgroundColor = dataSource.buttonBackgroundColor()
            button.setTitle("選項\(index)", for: .normal)
            button.titleLabel?.font = dataSource.textFont()
            
            dataSource.buttonForRowAt(self, index: index, button: button)
            
            button.tag = index
            button.addTarget(self, action: #selector(isSelect(sender:)), for: .touchDown)
            customButtons.append(button)
        }
        
        return customButtons
    }
    
    @objc dynamic func isSelect(sender: UIButton) {
        currentSelectedIndex = sender.tag // 目前被點選的 index
        
        guard let delegate = delegate else { return }
        
        if delegate.isEnableBeSelectAt(self, index: sender.tag) {
            
            UIView.animate(withDuration: 0.3) {
                self.IndicatorView.center.x = sender.center.x
            }
            
            delegate.didSelectAt(self, index: sender.tag)
        } else {
            print("\(sender.tag) isEnable")
        }
    }
    
}

// 負責外觀數量決定 button 外觀數量
protocol SelectionViewDataSource {
    
    func numberOfSelectBTN(_ selectView: SelectionView) -> Int
    func buttonForRowAt(_ selectView: SelectionView, index: Int, button: UIButton)
    func textColor() -> UIColor
    func indicatorColor() -> UIColor
    func textFont() -> UIFont
    func buttonBackgroundColor() -> UIColor
    
}

// 提供預設值
extension SelectionViewDataSource {
    
    func numberOfSelectBTN(_ selectView: SelectionView) -> Int {
        return 2
    }
    
    func buttonForRowAt(_ selectView: SelectionView, index: Int, button: UIButton) {
        button.backgroundColor = buttonBackgroundColor()
        button.setTitle("選項\(index)", for: .normal)
        button.titleLabel?.font = textFont()
        button.tintColor = textColor()
    }
    
    func textColor() -> UIColor {
        return .white
    }
    
    func indicatorColor() -> UIColor {
        return .blue
    }
    
    func textFont() -> UIFont {
        return UIFont.systemFont(ofSize: 18)
    }
    
    func buttonBackgroundColor() -> UIColor {
        return .black
    }
}

// 負責點擊事件
protocol SelectionViewDelegate: AnyObject {
    
    func didSelectAt(_ selectView: SelectionView, index: Int)
    
    func isEnableBeSelectAt(_ selectView: SelectionView, index: Int) -> Bool
    
}

// 提供預設值
extension SelectionViewDelegate {
    
    func didSelectAt(_ selectView: SelectionView, index: Int) {
        
    }
    
    func isEnableBeSelectAt(_ selectView: SelectionView, index: Int) -> Bool {
        return true
    }
    
}
