//
//  NoticeMeTests.swift
//  NoticeMeTests
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import XCTest
import JRDB
@testable import NoticeMe


class NoticeMeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
    }

    func testDropTable() {
        JRDBMgr.defaultDB().deleteTable4Clazz(CountDownModel)
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
