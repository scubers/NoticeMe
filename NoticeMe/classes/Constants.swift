//
//  ConstantStrign.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/19.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import Foundation
import UIKit

// MARK: - NSNotificationCenter
struct Notifications {
    struct Global {
         /// post by 1 second
        static let TimerBeat = "TimerBeatNotification"
    }
}

// MARK: - constant
struct Colors {
    struct Wave {
        static let Color1 = UIColor.jr_fullRgbaColor(r: 0, g: 189, b: 248, a: 1)
        static let Color2 = UIColor.jr_fullRgbaColor(r: 0, g: 189, b: 248, a: 0.7)
        static let Background = UIColor.jr_fullRgbaColor(r: 25, g: 56, b: 76, a: 1)
    }
    
    static let White     = UIColor.whiteColor()
    static let Black     = UIColor.blackColor()
    static let Purple    = UIColor.purpleColor()
    static let Gray      = UIColor.grayColor()
    static let LightGray = UIColor.lightGrayColor()
    static let Blue      = UIColor.blueColor()
    static let Red       = UIColor.redColor()
    static let Green     = UIColor.greenColor()
    static let Yellow    = UIColor.yellowColor()
}

// MARK: - configuration
class Config {
    static var BaseColor: UIColor = Colors.Wave.Color1
    
    static var AddMaxInterval: NSTimeInterval = 60 * 10
}





