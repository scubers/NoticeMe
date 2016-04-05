//
//  NTAppLifeMgr.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import MagicalRecord

class NTAppLifeMgr: NSObject {

    private override init() {}
    static let shareInstance: NTAppLifeMgr = NTAppLifeMgr()
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    func application(application: UIApplication, didfinishLaunchWith launchOptions:[NSObject: AnyObject]?) -> Bool {

        appDelegate.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        appDelegate.window?.rootViewController = configureRootViewController()
        appDelegate.window?.makeKeyAndVisible()

        jr_delay(1, queue: dispatch_get_main_queue()) { () -> Void in
            let nav = NTMainNavgationController(rootViewController: NTMainMenuViewController())
            self.appDelegate.window?.rootViewController = nav
        }

        MagicalRecord.setupCoreDataStackWithStoreNamed("Database.sqlite")

        return true
    }

    /**
     根据情况初始化rootViewController

     - returns: rootViewController
     */
    private func configureRootViewController() -> UIViewController {
        let wvc = NTWelcomeViewController()

        return wvc
    }


}
