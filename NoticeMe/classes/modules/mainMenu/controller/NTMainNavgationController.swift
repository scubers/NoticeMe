//
//  NTMainNavgationController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import BlocksKit

class NTMainNavgationController: UINavigationController {


    var navigationBarAlpha: CGFloat = 1 {
        didSet {
            setNavigationAlpha(navigationBarAlpha, color: navigationBarColor)
        }
    }
    var navigationBarColor: UIColor = UIColor.whiteColor() {
        didSet {
            setNavigationAlpha(navigationBarAlpha, color: navigationBarColor)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    private func setNavigationAlpha(alpha:CGFloat, color: UIColor) {
        let size = CGSizeMake(view.bounds.size.width, 64)
        let pointer : UnsafePointer<CGFloat> = CGColorGetComponents(jr_optional(color.CGColor))
        let img = UIImage.imageWithColor(UIColor(red: pointer[0], green: pointer[1], blue: pointer[2], alpha: alpha), size: size)
        self.navigationBar.setBackgroundImage(img, forBarMetrics: .Default)
        self.navigationBar.shadowImage = UIImage.imageWithColor(UIColor.clearColor(), size: CGSizeMake(size.width, 1))
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    func test() {
        var arr = NSArray()

        jr_pointer(&arr)

        
    }

}
