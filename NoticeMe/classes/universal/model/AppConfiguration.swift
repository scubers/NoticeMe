//
//  NTAppConfiguration.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/1.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class AppConfiguration: NSObject {

    private override init() {
        super.init()
    }

    static let shareInstance = AppConfiguration()

    var appCommonFont: CGFloat       = 14
    var navigationTitleFont: CGFloat = 15
    var navigationItemFont: CGFloat  = 13

}
