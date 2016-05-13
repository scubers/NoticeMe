//
//  AppDelegate+Launching.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/13.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import Foundation
import JRUtils
import JRDB

extension AppDelegate {

    func setupKeyWindow() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = configureRootViewController()
        window?.makeKeyAndVisible()

        jr_delay(0.5, queue: dispatch_get_main_queue()) { () -> Void in
            let nav = BaseNavigationController(rootViewController: MainViewController())
            self.window?.rootViewController = nav
        }

        JRDBMgr.shareInstance().registerClazzForUpdateTable(CountDownModel)
        JRDBMgr.shareInstance().updateDefaultDB()

    }

    private func configureRootViewController() -> UIViewController {
        let wvc = WelcomeViewController()
        return wvc
    }

}