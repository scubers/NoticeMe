//
//  Disposable.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/4.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import Foundation
import RxSwift

extension NSObject {

    func getDisposeBag() -> DisposeBag {
        var disposeBagKey = "disposeBagKey"
        if let bag = objc_getAssociatedObject(self, &disposeBagKey) {
            return bag as! DisposeBag
        }
        let bag = DisposeBag()
        objc_setAssociatedObject(self, &disposeBagKey, bag, .OBJC_ASSOCIATION_RETAIN)
        return bag

    }
}

