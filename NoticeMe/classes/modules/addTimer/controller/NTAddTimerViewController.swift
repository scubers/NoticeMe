//
//  NTAddTimerViewController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import MagicalRecord

class NTAddTimerViewController
    : NTViewController {

    lazy var context = NSManagedObjectContext.MR_contextWithParent(NSManagedObjectContext.MR_defaultContext())

    lazy var countDownModel: NTCountDownModel? = NTCountDownModel.MR_createEntityInContext(self.context)

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .OverCurrentContext
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    var tableView: UITableView?
    var tableViewHandler: NTAddTimerTableViewHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    func setupSubviews() {
        tableView = UITableView(frame: view.frame, style: .Grouped)
        view.addSubview(tableView!)

        tableView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        tableViewHandler = NTAddTimerTableViewHandler(tableView: self.tableView!)

        setupSignal()
    }

    func setupSignal() {

        tableView?.rx_contentOffset.subscribeNext({[weak self] (point) in
            if point.y < -150 && self!.tableView!.dragging {
                self?.dismissViewControllerAnimated(true, completion: nil)
            }
        }).addDisposableTo(getDisposeBag())

        // MARK: 绑定数据
        tableViewHandler?.rx_interval.subscribeNext({[weak self] (interval) in
            self?.countDownModel?.interval = interval
        }).addDisposableTo(getDisposeBag())

        tableViewHandler?.rx_audio.subscribeNext({[weak self] (audio) in
            self?.countDownModel?.audio = audio
        }).addDisposableTo(getDisposeBag())

        tableViewHandler?.rx_animation.subscribeNext({[weak self] (animation) in
            self?.countDownModel?.animation = animation
        }).addDisposableTo(getDisposeBag())


    }

}