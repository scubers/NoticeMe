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
import JRUtils

class MainTableViewHandler: NSObject {
    
    // 通知外界的信号
    var rx_show = PublishSubject<Bool>();
    var rx_showSettings = PublishSubject<Bool>();
    var rx_selecteModel = PublishSubject<(model:CountDownModel, indexpath:NSIndexPath)>();
    
    var interactable = true

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
        self.tableView.contentInset.top += (30)
        reloadModels()
    }

    // MARK: - 提供给外面的操纵方法
    func reloadModels() {
        // TODO: 重新查询数据库
        countDownModels = CountDownModel.jr_findByConditions(nil, groupBy: nil, orderBy: "createDate", limit: nil, isDesc: true) as! [CountDownModel]
        tableView.reloadData()
    }
}

private let topExtra: CGFloat = 60
private let topInset: CGFloat = 30


extension MainTableViewHandler: UITableViewDelegate {
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.y < -(scrollView.contentInset.top + 50) {
            rx_show.onNext(true)
        }
        
        if scrollView.contentSize.height < scrollView.jr_height {
            if scrollView.contentOffset.y > 50 {
                rx_showSettings.onNext(true)
            }
        }
        else if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.jr_height + 50) {
            rx_showSettings.onNext(true)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = countDownModels[indexPath.row]
        dispatch_async(dispatch_get_main_queue()) {
            self.rx_selecteModel.onNext((model: model,indexpath: indexPath))
        }
    }
    
}

extension MainTableViewHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countDownModels.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.self.description()) as! MainTableViewCell
        configureCell(cell, indexpath: indexPath)
//        cell.backgroundColor = UIColor.jr_randomColor()
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = countDownModels[indexPath.row]
        return tableView.cellHeightForIndexPath(indexPath, model: model, keyPath: "countDownModel", cellClass: MainTableViewCell.self, contentViewWidth: tableView.jr_width) + 1
//        configureCell(tempCell, indexpath: indexPath)
//        let height = tempCell.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
//        return height + 1
    }

    func configureCell(cell: MainTableViewCell, indexpath: NSIndexPath) {
        let model = countDownModels[indexpath.row]
        cell.countDownModel = model
    }


}
