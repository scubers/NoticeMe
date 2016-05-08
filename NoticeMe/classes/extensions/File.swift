//
//  File.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import Foundation

extension NSUserDefaults {
    static func saveObj<T: AnyObject>(obj: T?, toDefaults withKey: String) -> Bool {
        self.standardUserDefaults().setObject(obj, forKey: withKey);
        return self.jr_synchronize()
    }

    static func jr_synchronize() -> Bool {
        return self.standardUserDefaults().synchronize()
    }
}