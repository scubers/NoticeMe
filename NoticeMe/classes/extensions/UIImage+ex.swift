//
//  UIImage+ex.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/31.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit


extension UIImage {

    static func imageWithColor(color:UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        color.set()
        UIRectFill(CGRectMake(0, 0, size.width, size.height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
