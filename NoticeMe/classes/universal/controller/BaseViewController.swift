//
//  NTViewController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
