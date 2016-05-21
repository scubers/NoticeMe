//
//  AnimationType.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/20.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import Foundation

enum AnimationType : Int {
    case Point = 0
    case Wave
    case AnimationTypeCount
}

extension AnimationType {
    func getClazz() -> AnyClass! {
        switch self {
        case .Point: return PointCountDownController.self
        case .Wave: return WaveCountDownController.self
        case .AnimationTypeCount: return nil
        }
    }
}