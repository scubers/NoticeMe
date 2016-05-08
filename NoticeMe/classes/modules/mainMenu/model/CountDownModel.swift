//
//  CountDownModel.swift
//  
//
//  Created by 王俊仁 on 16/5/8.
//
//

import Foundation
import CoreData


class CountDownModel: NSManagedObject {

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
