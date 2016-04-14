//
//  NTCountDownTaskModel+CoreDataProperties.swift
//  
//
//  Created by 王俊仁 on 16/4/14.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension NTCountDownTaskModel {

    @NSManaged var id: String?
    @NSManaged var endDate: NSDate?
    @NSManaged var createDate: NSDate?
    @NSManaged var countDownModel: NTCountDownModel?

}
