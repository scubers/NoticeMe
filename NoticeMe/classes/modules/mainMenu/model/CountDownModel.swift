//
//  CountDownModel.swift
//  
//
//  Created by 王俊仁 on 16/5/8.
//
//

import Foundation


class CountDownModel: NSObject {

    var createDate: NSDate?
    var interval: Double = 60 * 3
    var title: String?
    var repeatType: Int = RepeatType.None.rawValue
    var countDownState: Int = CountDownState.Idle.rawValue
    
    var startDate: NSDate?
    var updateDate: NSDate?
    var animation: String?

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
