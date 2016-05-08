//
//  MainViewController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

enum MainViewState {
    case Default
    case Adding
}

class MainViewController: BaseViewController {

    var addTimerView: AddTimerView!
    var tableView: UITableView!
    var tableViewHandler: MainTableViewHandler!
    var tipsLayer: CAShapeLayer? = CAShapeLayer()

    var state: MainViewState = .Default

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupUI()


    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - 私有方法
    private func setupUI() {
        tableView = UITableView(frame: view.bounds, style: .Plain)
        view.addSubview(tableView)
        tableViewHandler = MainTableViewHandler(tableView: tableView)

        addTimerView = AddTimerView(frame: view.bounds)
        addTimerView.frame.origin.y = -addTimerView.frame.size.height
        view.addSubview(addTimerView)


        tableView.rx_contentOffset.subscribeNext {[weak self] (point) in
            if self!.state == .Default {
                var y = self!.addTimerView.frame.origin.y - (point.y + self!.tableView.contentInset.top)
                y = y > 0 ? 0 : y
                self!.addTimerView.frame.origin.y = y
            }


        }.addDisposableTo(self.getDisposeBag())

        tableViewHandler.rx_dragging.subscribeNext { (dragging, decelerate) in
        }.addDisposableTo(self.getDisposeBag())

    }

}
