//
//  PublicMethod.swift
//  SwiftDemo
//
//  Created by Jren on 15/12/17.
//  Copyright © 2015年 jr-wong. All rights reserved.
//

import Foundation
import UIKit

/**
 *获取appDelegate
 */
func appDelegate() -> AppDelegate? {
    return (UIApplication.sharedApplication().delegate as? AppDelegate)!
}

/**
 *获取包版本
 */
func bundleVersion() -> String? {
    return (NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as? String;
}

/**
 *系统版本 ios7.8.9
 */
func systemVersion() -> Double {
    return Double(UIDevice.currentDevice().systemVersion)!
}

// MARK: - 路径
func documentsDirectory() -> String {
    return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
}
func libraryDirectory() -> String {
    return NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true).first!
}
func cacheDirectory() -> String {
    return NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first!
}

