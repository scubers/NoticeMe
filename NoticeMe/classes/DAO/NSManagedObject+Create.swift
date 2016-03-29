//
//  NSManagedObject+Create.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/29.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    static func newInstanceWith(context: NSManagedObjectContext, name: String) -> NSManagedObject {
        let obj = NSEntityDescription.insertNewObjectForEntityForName(name, inManagedObjectContext: context)
        return obj
    }
}