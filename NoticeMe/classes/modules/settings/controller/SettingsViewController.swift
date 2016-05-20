//
//  SettingsViewController.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/20.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    var tableView: UITableView!
    var tableViewHandler: SettingsTableViewHandler!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupTableView()
        setupSignal()
    }
    
    private func setupSignal() {
        tableViewHandler
            .rx_end
            .subscribeNext {[weak self] (flag) in
                self?.dismissViewControllerAnimated(true, completion: nil)
            }.addDisposableTo(self.getDisposeBag())
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .Plain)
        tableView.separatorStyle = .None
        view.addSubview(tableView)
        tableViewHandler = SettingsTableViewHandler(tableView: tableView)
        tableViewHandler.groups.append(createGroup1())
    }
    
    enum SettingsRowID : String {
        case Title1
        case Title2
    }
    
    // MARK: - composing
    private func createGroup1() -> BaseSettingsGroup {
        let group = BaseSettingsGroup()
        
        group.items.append(createItem1())
        group.items.append(createItem2())
        
        return group
    }
    
    private func createItem1() -> BaseSettingsItem {
        let item = createCommonItem(.Title1)
        return item
    }
    private func createItem2() -> BaseSettingsItem {
        let item = createCommonItem(.Title2)
        return item
    }
    
    private func createCommonItem(reuseId: SettingsRowID) -> BaseSettingsItem {
        let item = BaseSettingsItem()
        item.reuseId = reuseId.rawValue
        item.heightForCell = 40
        item.titleText = reuseId.rawValue
        item.hideSeperateLine = true
        return item
    }
    
}
