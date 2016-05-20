//
//  SettingsTableViewHandler.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/20.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import RxSwift
import JRUtils

class SettingsTableViewHandler: BaseSettingsTableViewHandler {
    
    var rx_end: PublishSubject<Bool> = PublishSubject()
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView.contentOffset.y < -(scrollView.contentInset.top + 50) {
            rx_end.onNext(true)
        }
        
    }
}
