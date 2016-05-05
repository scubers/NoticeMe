//
//  NTAddTimerTableViewHandler.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/18.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit

class NTAddTimeAudioCollectionViewHandler
    : NSObject
    , UICollectionViewDataSource
    , UICollectionViewDelegate {

    var collectionView: UICollectionView?

    lazy var rx_audioDidSelected = PublishSubject<String>()

    convenience init(collectionView: UICollectionView) {
        self.init()

        collectionView.dataSource = self
        collectionView.delegate   = self
        self.collectionView = collectionView

        self.collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "123")

        rx_audioDidSelected.addDisposableTo(getDisposeBag())
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier("123", forIndexPath: indexPath)
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let indexpath = collectionView?.indexPathsForVisibleItems().last
        rx_audioDidSelected.onNext(indexpath!.description)
    }
}

class NTAddTimeAnimationCollectionViewHandler
    : NSObject
    , UICollectionViewDataSource
    , UICollectionViewDelegate {

    var collectionView: UICollectionView?

    lazy var rx_animationDidSelected = PublishSubject<String>()

    convenience init(collectionView: UICollectionView) {
        self.init()
        collectionView.dataSource = self
        collectionView.delegate   = self
        self.collectionView = collectionView
        self.collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "234")

        rx_animationDidSelected.addDisposableTo(getDisposeBag())
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier("234", forIndexPath: indexPath)
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let indexpath = collectionView?.indexPathsForVisibleItems().last
        rx_animationDidSelected.onNext(indexpath!.description)
    }
}


class NTAddTimerTableViewHandler: BaseSettingsTableViewHandler {

    var tableView: UITableView?

    lazy var rx_interval  = PublishSubject<NSNumber>()
    lazy var rx_audio     = PublishSubject<String>()
    lazy var rx_animation = PublishSubject<String>()

    var audioHandler: NTAddTimeAudioCollectionViewHandler?
    var animationHandler: NTAddTimeAnimationCollectionViewHandler?


    override init() {
        super.init()
        setupHandlerData()
    }

    convenience init(tableView: UITableView) {
        self.init()

        tableView.dataSource = self
        tableView.delegate   = self
        self.tableView = tableView
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

    // MARK: 倒数时间组
    func setupTimeGroup() -> BaseSettingsGroup {
        let group = createCommonGroup()
        group.items.append(setupCountDownTimeCell())
        return group
    }

    func setupCountDownTimeCell() -> BaseSettingsItem {
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
            let interval = NSNumber(double: Double(value) * maxSecond)
            self?.rx_interval.onNext(interval)
            }.addDisposableTo(getDisposeBag())
        rx_interval.addDisposableTo(getDisposeBag())

        return item
    }

    // MARK: 提醒声音组
    func setupAudioGroup() -> BaseSettingsGroup  {
        let group = createCommonGroup()
        group.items.append(setupAudioCell())
        return group
    }

    func setupAudioCell() -> BaseSettingsItem {
        let item                = createCommonItem()
        item.reuseId            = COUNT_DOWN_AUDIO_CELL_ID
        item.heightForCell      = 120
        item.settingsType       = BaseSettingsItemType.AllCustomize

        let base                = UIView()
        item.baseBackgroundView = base

        let layout             = UICollectionViewFlowLayout()
        layout.itemSize        = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 10, item.heightForCell - 10)
        layout.scrollDirection = .Horizontal

        let cv     = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        cv.pagingEnabled = true
        base.addSubview(cv)

        cv.snp_makeConstraints { (make) in
            make.edges.equalTo(cv.superview!)
        }

        cv.backgroundColor = UIColor.purpleColor()

        audioHandler = NTAddTimeAudioCollectionViewHandler(collectionView: cv)
        rx_audio = audioHandler!.rx_audioDidSelected

        return item
    }

    // MARK: 倒数动画组
    func setupAnimationGroup() -> BaseSettingsGroup {
        let group = createCommonGroup()
        group.items.append(setupAnimationCell())
        return group
    }

    func setupAnimationCell() -> BaseSettingsItem {
        let item = createCommonItem()
        item.reuseId = COUNT_DOWN_ANIMATION_ID
        item.heightForCell = 100

        let base                = UIView()
        item.baseBackgroundView = base

        let layout             = UICollectionViewFlowLayout()
        layout.itemSize        = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 10, item.heightForCell - 10)
        layout.scrollDirection = .Horizontal

        let cv     = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        cv.pagingEnabled = true
        base.addSubview(cv)

        cv.snp_makeConstraints { (make) in
            make.edges.equalTo(cv.superview!)
        }

        animationHandler = NTAddTimeAnimationCollectionViewHandler(collectionView: cv)

        return item
    }

    // MARK: 通用私有方法
    private func createCommonGroup() -> BaseSettingsGroup {
        let group = BaseSettingsGroup()
        return group
    }

    private func createCommonItem() -> BaseSettingsItem {
        let item = BaseSettingsItem()
        item.reuseId = ""
        item.heightForCell = 50
        item.settingsType = .None
        item.clearHighLight = true
        return item
    }
    
}