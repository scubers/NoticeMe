//
//  NTTableViewDataSourceHandler.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/15.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit


class NTTableViewDataSourceHandler: NSObject, UITableViewDataSource {

    typealias NumberOfSectionBlock = (UITableView) -> Int
    typealias NumberOfRowInSectionBlock = (UITableView, Int) -> Int
    typealias CellForRowBlock = (UITableView, NSIndexPath) -> UITableViewCell
    typealias TitleForHeaderBlock = (UITableView, Int) -> String?
    typealias TitleForFooterBlock = (UITableView, Int) -> String?
    typealias CanEditRowBlock = (UITableView, NSIndexPath) -> Bool
    typealias CanMoveRowBlock = (UITableView, NSIndexPath) -> Bool
    typealias SectionIndexTitlesBlock = (UITableView) -> [String]?
    typealias SectionForSectionIndexTitle = (UITableView, String, Int) -> Int



    var numberOfSectionBlock: NumberOfSectionBlock?
    var numberOfRowInSectionBlock: NumberOfRowInSectionBlock?
    var cellForRowBlock: CellForRowBlock!
    var titleForHeaderBlock: TitleForHeaderBlock?
    var titleForFooterBlock: TitleForFooterBlock?
    var canEditRowBlock: CanEditRowBlock?
    var canMoveRowBlock: CanMoveRowBlock?
    var sectionIndexTitlesBlock: SectionIndexTitlesBlock?




    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let mblock = numberOfSectionBlock else {
            return 0
        }
        return mblock(tableView)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mblock = numberOfRowInSectionBlock else {
            return 0
        }
        return mblock(tableView, section)
    }

    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return cellForRowBlock(tableView, indexPath)
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    {
        guard let mblock = titleForHeaderBlock else {
            return nil
        }
        return mblock(tableView, section)
    }

    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let mblock = titleForFooterBlock else {
            return nil
        }
        return mblock(tableView, section)

    }

    // Editing

    // Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        guard let mblock = canEditRowBlock else {
            return false
        }
        return mblock(tableView, indexPath)
    }

    // Moving/reordering

    // Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        guard let mblock = canMoveRowBlock else {
            return false
        }
        return mblock(tableView, indexPath)
    }

    // Index
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    {
        guard let mblock = sectionIndexTitlesBlock else {
            return nil
        }
        return mblock(tableView)
    }

//    optional public func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int // tell table which section corresponds to section title/index (e.g. "B",1))

    // Data manipulation - insert and delete support

    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
//    @available(iOS 2.0, *)
//    optional public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)

    // Data manipulation - reorder / moving support

//    @available(iOS 2.0, *)
//    optional public func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)


}
