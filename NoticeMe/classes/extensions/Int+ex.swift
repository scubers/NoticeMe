//
//  Int+ex.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/31.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import Foundation

extension Int {
    func times(f: (i: Int)->()) {
        for i in 1...self {
            f(i: i)
        }
    }
}