//
//  CountDownModel+CoreDataProperties.swift
//  
//
//  Created by 王俊仁 on 16/5/8.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CountDownModel {

    @NSManaged var animation: String?
    @NSManaged var audio: String?
    @NSManaged var createDate: NSDate?
    @NSManaged var id: String?
    @NSManaged var interval: NSNumber?
    @NSManaged var startDate: NSDate?
    @NSManaged var updateDate: NSDate?
    @NSManaged var repeatType: NSNumber?
    @NSManaged var countDownState: NSNumber?
    @NSManaged var title: String?

}
