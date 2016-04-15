//
//  NTAddTimerViewController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import ReactiveCocoa
import SnapKit
import CoreData
import Aspects

class NTAddTimerTableViewHandler: NTBaseSettingsTableViewHandler {

    var countDownModel: NTCountDownModel?
    override init() {
        super.init()
        setupHandlerData()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.backgroundColor = jr_randomColor()
        return cell
    }

    // MARK: 组建数据

    let COUNT_DOWN_TIME_CELL_ID  = "COUNT_DOWN_TIME_CELL_ID"
    let COUNT_DOWN_AUDIO_CELL_ID = "COUNT_DOWN_AUDIO_CELL_ID"
    let COUNT_DOWN_ANIMATION_ID  = "COUNT_DOWN_ANIMATION_ID"

    func setupHandlerData() {
        groups.append(setupTimeGroup())
        groups.append(setupAudioGroup())
        groups.append(setupAnimationGroup())
    }

    func setupTimeGroup() -> NTBaseSettingsGroup {
        let group = createCommonGroup()
        group.items.append(setupCountDownTimeCell())
        return group
    }

    func setupCountDownTimeCell() -> NTBaseSettingsItem {
        let item = createCommonItem()
        item.reuseId = COUNT_DOWN_TIME_CELL_ID
        item.heightForCell = 120
        item.settingsType = .AllCustomize

        let base = UIView()

        base.backgroundColor = UIColor.blackColor()
        item.baseBackgroundView = base

        
        let slider = UISlider()
        base.addSubview(slider)

        slider.value = 0.5
        slider.snp_makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.right.equalTo(slider.superview!).inset(EdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
            make.center.equalTo(slider.superview!)
        }

        let maxSecond: NSTimeInterval = 60.0 * 3.0
        slider.rx_value.subscribeNext {[weak self] (value) in
            print(value)
            self?.countDownModel?.interval = NSNumber(double: Double(value) * maxSecond)
        }.addDisposableTo(getDisposeBag())



        return item
    }

    func setupAudioGroup() -> NTBaseSettingsGroup {
        let group = createCommonGroup()
        group.items.append(setupAudioCell())
        return group
    }

    func setupAudioCell() -> NTBaseSettingsItem {
        let item = createCommonItem()
        item.reuseId = COUNT_DOWN_AUDIO_CELL_ID
        item.heightForCell = 80

        let base = UIView()
        item.baseBackgroundView = base



        return item
    }
    func setupAnimationGroup() -> NTBaseSettingsGroup {
        let group = createCommonGroup()
        group.items.append(setupAnimationCell())
        return group
    }

    func setupAnimationCell() -> NTBaseSettingsItem {
        let item = createCommonItem()
        item.reuseId = COUNT_DOWN_ANIMATION_ID
        item.heightForCell = 100
        return item
    }


    private func createCommonGroup() -> NTBaseSettingsGroup {
        let group = NTBaseSettingsGroup()
        return group
    }

    private func createCommonItem() -> NTBaseSettingsItem {
        let item = NTBaseSettingsItem()
        item.reuseId = ""
        item.heightForCell = 50
        item.settingsType = .None
        item.clearHightLight = true
        return item
    }

}

class NTAddTimerViewController: NTViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .OverCurrentContext
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var tableView: UITableView?
    lazy var tableViewHandler: NTAddTimerTableViewHandler? = NTAddTimerTableViewHandler()

    override func viewDidLoad() {
        super.viewDidLoad()


        setupSubviews()

    }

    func setupSubviews() {
        tableView = UITableView(frame: view.frame, style: .Grouped)
        view.addSubview(tableView!)

        tableView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        tableView?.delegate = tableViewHandler
        tableView?.dataSource = tableViewHandler

        setupSignal()
    }

    func setupSignal() {

        tableView?.rx_contentOffset.subscribeNext({[weak self] (point) in
            if point.y < -150 && self!.tableView!.dragging {
                self?.dismissViewControllerAnimated(true, completion: nil)
            }
        }).addDisposableTo(getDisposeBag())
    }

}
