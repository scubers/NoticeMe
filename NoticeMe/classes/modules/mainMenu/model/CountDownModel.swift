//
//  CountDownModel.swift
//  
//
//  Created by 王俊仁 on 16/5/8.
//
//

import Foundation


class CountDownModel: NSObject {

    var animation: String?
    var audio: String?
    var createDate: NSDate?
    var interval: NSNumber?
    var startDate: NSDate?
    var updateDate: NSDate?
    var repeatType: NSNumber?
    var countDownState: NSNumber?
    var title: String?

    var repeatTypeEnum: RepeatType {
        get {
            return RepeatType(rawValue: Int(repeatType?.intValue ?? 0))!
        }
        set {
            repeatType = NSNumber(int: Int32(newValue.hashValue))
        }
    }

    var countDownStateEnum: RepeatType {
        get {
            return RepeatType(rawValue: Int(countDownState?.intValue ?? 0))!
        }
        set {
            repeatType = NSNumber(int: Int32(newValue.hashValue))
        }
    }

}
