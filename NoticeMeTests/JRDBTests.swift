//
//  JRDBTests.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/12.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import XCTest
import JRDB;

class Person: NSObject {
    
}

class JRDBTests: XCTestCase {

    var db: FMDatabase = JRDBMgr.shareInstance().createDBWithPath("/Users/Jrwong/Desktop/test.sqlite")

    override func setUp() {
        super.setUp()
        JRDBMgr.shareInstance().registerClazzForUpdateTable(Person)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
