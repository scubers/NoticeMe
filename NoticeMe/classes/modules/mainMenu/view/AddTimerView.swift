//
//  AddTimerView.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class AddTimerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = jr_randomColor()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
