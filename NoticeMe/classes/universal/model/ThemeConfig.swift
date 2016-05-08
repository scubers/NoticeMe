//
//  NTAppConfiguration.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/1.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class ThemeConfig: NSObject {

    private override init() {
        super.init()
    }

    static let shareInstance = ThemeConfig()

    // MARK: - Globle Config
    var g_font: CGFloat = 14

    // MARK: - 导航栏样式
    var n_TitleFont: CGFloat = 15
    var n_ItemFont: CGFloat  = 13

    // MARK: - 主列表
}
