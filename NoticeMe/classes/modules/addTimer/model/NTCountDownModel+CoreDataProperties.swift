//
//  NTCountDownModel+CoreDataProperties.swift
//  
//
//  Created by 王俊仁 on 16/4/5.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension NTCountDownModel {

    @NSManaged var animation: String?
    @NSManaged var audio: String?
    @NSManaged var createDate: NSDate?
    @NSManaged var fireDate: NSDate?
    @NSManaged var interval: NSNumber?
    @NSManaged var startDate: NSDate?
    @NSManaged var updateDate: NSDate?
    @NSManaged var id: String?

}