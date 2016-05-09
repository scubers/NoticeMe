//
//  AddTimerView.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import RxSwift

class AddTimerView: UIView {

    var rx_paning = PublishSubject<(UIPanGestureRecognizer)>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 0.8)
        layer.shadowOffset = CGSizeMake(0, 10)
        layer.shadowColor = UIColor.blackColor().CGColor
        setupUI()
        setupGesture()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {

    }

    func setupGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(AddTimerView.handlePan(_:)))
        addGestureRecognizer(pan)
    }

    func handlePan(reco: UIPanGestureRecognizer?)  {
        rx_paning.onNext(reco!)
    }
}
