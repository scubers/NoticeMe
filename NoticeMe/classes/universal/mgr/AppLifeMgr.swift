//
//  NTAppLifeMgr.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import JRDB
import JRUtils

class AppLifeMgr: NSObject {

    private override init() {}
    static let shareInstance: AppLifeMgr = AppLifeMgr()
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    func application(application: UIApplication, didfinishLaunchWith launchOptions:[NSObject: AnyObject]?) -> Bool {


        return true
    }

    /**
     根据情况初始化rootViewController

     - returns: rootViewController
     */
    private func configureRootViewController() -> UIViewController {
        let wvc = WelcomeViewController()

        return wvc
    }


}
