//
//  AppDelegate+Launching.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/13.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import Foundation
import JRUtils
import JRDBSwift

extension AppDelegate {

    // MARK: - Key window
    func setupKeyWindow() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = configureRootViewController()
        window?.makeKeyAndVisible()

        jr_delay(0.5, queue: dispatch_get_main_queue()) { () -> Void in
            let nav = BaseNavigationController(rootViewController: MainViewController())
            self.window?.rootViewController = nav
        }
        JRDBMgr.shareInstance().registerClazzes([
            CountDownModel.self,
            ]);
//        JRDBMgr.shareInstance()
        JRDBMgr.shareInstance().updateDefaultDB()

    }
    
    private func configureRootViewController() -> UIViewController {
        let wvc = WelcomeViewController()
        return wvc
    }

    
    // MARK: - Global Timer
    func setupGlobalTimer() {
        stopGlobalTimer()
        globalTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AppDelegate.timerBeat(_:)), userInfo: nil, repeats: true)
    }
    func stopGlobalTimer() {
        globalTimer?.invalidate()
        globalTimer = nil
    }
    @objc
    private func timerBeat(timer:NSTimer) {
        NSNotificationCenter.defaultCenter().postNotificationName(Notifications.Global.TimerBeat, object: nil)
    }
    
    
}