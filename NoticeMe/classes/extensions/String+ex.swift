//
//  String+ex.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/1.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import Foundation

extension String {
    /**
     直接传入String，返回的就是c中的字符串指针 char *
     - parameter string: 字符串
     - returns: char *
     */
    static func toCStringUnsafePointer(string: UnsafePointer<Int8>) -> UnsafePointer<Int8> {
        return string
    }
}