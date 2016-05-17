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
    var createDate: NSDate?
    var interval: Double = 0
    var startDate: NSDate?
    var updateDate: NSDate?
    var repeatType: Int = RepeatType.None.rawValue
    var countDownState: Int = CountDownState.Idle.rawValue
    var title: String?

    var repeatTypeEnum: RepeatType {
        get {
            return RepeatType(rawValue: repeatType)!
        }
        set {
            repeatType = newValue.rawValue
        }
    }

    var countDownStateEnum: RepeatType {
        get {
            return RepeatType(rawValue: countDownState)!
        }
        set {
            repeatType = newValue.rawValue
        }
    }

}
