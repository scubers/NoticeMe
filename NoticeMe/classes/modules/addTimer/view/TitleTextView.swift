//
//  TitleTextView.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/17.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import RxSwift

class TitleTextView: UIView {
    
    var textField: UITextField!
    var rx_doneClick = PublishSubject<String?>()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        textField = UITextField()
        textField.placeholder = "what do you want to do"
        textField.returnKeyType = .Done
        textField.delegate = self
        addSubview(textField)
        
        textField.sd_layout()
            .spaceToSuperView(UIEdgeInsetsZero)
//        textField.snp_makeConstraints { (make) in
//            make.edges.equalTo(textField.superview!)
//        }
    }
    
}

extension TitleTextView : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        rx_doneClick.onNext(textField.text)
        return true
    }
}
