//
//  MainTableViewHandler.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import RxSwift
import JRDB

class MainTableViewHandler: NSObject {

    var rx_dragging = PublishSubject<(Bool, Bool)>()

    // MARK: - 管理的tablview
    var tableView: UITableView!
    var countDownModels: [CountDownModel]!

    lazy var tempCell: MainTableViewCell = MainTableViewCell(style: .Default, reuseIdentifier: "")

    // MARK: - 初始化方法
    convenience init(tableView: UITableView) {
        self.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .None

        self.tableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.self.description())
        self.tableView.contentInset.top += 30
        reloadModels()
    }

    // MARK: - 提供给外面的操纵方法
    func reloadModels() {
        // TODO: 重新查询数据库
        countDownModels = JRDBMgr.defaultDB().findAll(CountDownModel) as! [CountDownModel]
        tableView.reloadData()

        let model = CountDownModel()
        model.title = "龙看扥灵动减肥龙看扥灵动减肥龙看扥灵动减肥龙看扥灵动减肥龙看扥灵动减肥龙看扥灵动减肥龙看扥灵动减肥"
        model.interval = NSNumber(double: 180)
        countDownModels = [
            model,
            model,
            model,
            model,
            model,
            model,
            model,
            model,
            model,
            model,
            ]
    }
}

extension MainTableViewHandler: UITableViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        rx_dragging.onNext((true, false))
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        rx_dragging.onNext((false, decelerate))
    }
}

extension MainTableViewHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countDownModels.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.self.description()) as! MainTableViewCell
        configureCell(cell, indexpath: indexPath)
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        configureCell(tempCell, indexpath: indexPath)
        let height = tempCell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        return height + 1
    }

    func configureCell(cell: MainTableViewCell, indexpath: NSIndexPath) {
        let model = countDownModels[indexpath.row]
        cell.countDownModel = model
    }


}
