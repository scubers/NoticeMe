//
//  NTCountDownModel.swift
//  
//
//  Created by 王俊仁 on 16/4/5.
//
//

import Foundation
import CoreData


class NTCountDownModel: NSManagedObject {

    func copy2Model(newModel: NTCountDownModel) {
        newModel.fireDate  = fireDate
        newModel.audio     = audio
        newModel.startDate = startDate
        newModel.animation = animation
        newModel.interval  = interval
    }

}
