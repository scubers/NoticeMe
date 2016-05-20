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
    var animationType: Int = AnimationType.Point.rawValue
    
    
    var updateDate: NSDate?
    
    var intervalString: String {
        return string4(interval)
    }
    
    var restIntervalString: String {
        return string4(restInterval)
    }
    
    var restInterval: Double {
        if let st = startDate {
            let time = interval - NSDate().timeIntervalSinceDate(st)
            return time < 0 ? 0 : time
        }
        return 0
    }
    
    private func string4(interval: Double) -> String {
        let minute = Int(interval / 60)
        let second = Int(interval % 60)
        return "\(minute) : \(String(format: "%02d", second))"
    }
    

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
    
    var animationTypeEnum: AnimationType {
        get {
            return AnimationType(rawValue: animationType)!
        }
        set {
            animationType = newValue.rawValue
        }
    }
    
}
