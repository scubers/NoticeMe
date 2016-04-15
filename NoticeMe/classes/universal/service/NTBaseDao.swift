//
//  NTBaseDao.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/15.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import MagicalRecord

protocol NTBaseDao {

    func saveToDataBase()

    func isDefaultContext(context: NSManagedObjectContext) -> Bool

}

extension NTBaseDao {
    func saveToDataBase() {
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }

    func isDefaultContext(context: NSManagedObjectContext) -> Bool {
        return context == NSManagedObjectContext.MR_defaultContext()
    }
}