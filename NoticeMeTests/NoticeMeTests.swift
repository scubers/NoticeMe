//
//  NoticeMeTests.swift
//  NoticeMeTests
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import XCTest
import CoreData
import MagicalRecord
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
        let p = Person.newInstanceWith(CoreDataDAO.shareInstance.context, name: Person.self.description()) as? Person

        p?.name = "11"
        p?.age = 4

        CoreDataDAO.shareInstance.saveContext()

        let req = NSFetchRequest(entityName: Person.self.description())

        do {
            let arr: Array<Person> = try CoreDataDAO.shareInstance.context.executeFetchRequest(req) as! [Person]
            arr.forEach { (p: Person) -> () in
                print(p)
            }
        } catch {
        }

    }

    func testGet() {
        let req = NSFetchRequest(entityName: Person.self.description())


        let pre = NSPredicate(format: "age = %d", 4)

        req.predicate = pre

        do {
            let arr: Array<Person> = try CoreDataDAO.shareInstance.context.executeFetchRequest(req) as! [Person]

            print("\(arr.count)--------------")


        } catch {

        }

    }

    func testDelete() {
        let req = NSFetchRequest(entityName: Person.self.description())


        let pre = NSPredicate(format: "age = %d", 2)

        req.predicate = pre

        do {
            let arr: Array<Person> = try CoreDataDAO.shareInstance.context.executeFetchRequest(req) as! [Person]

            print("\(arr.count)--------------")

            arr.forEach({ (p:Person) -> () in
                CoreDataDAO.shareInstance.context.deleteObject(p)
            })

            CoreDataDAO.shareInstance.saveContext()
            
        } catch {
            
        }
    }

    func testabc() {

    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
