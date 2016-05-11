//
//  MainViewController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import JRUtils

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
                var y = -(point.y + self!.tableView.contentInset.top) - self!.addTimerView.jr_height
                y = y > 0 ? 0 : y
                self!.addTimerView.jr_y = y
            }


        }.addDisposableTo(self.getDisposeBag())

        tableViewHandler.rx_dragging.subscribeNext {[weak self] (dragging, decelerate) in
            if !dragging {
                if self!.tableView.contentOffset.y < -100 {
                    self?.state = .Adding
                    UIView.animateWithDuration(0.25, animations: { 
                        self?.addTimerView.jr_y = 0
                        }, completion: { (flag) in
                            
                    })
                }
            }
        }.addDisposableTo(self.getDisposeBag())


        addTimerView.rx_paning.subscribeNext {[weak self] (reco) in
            let adv = self!.addTimerView
            switch reco.state {
            case .Changed:
                let p = reco.translationInView(reco.view)
                adv.jr_y += p.y
                if adv.jr_y > 0 {
                    adv.jr_y = 0
                }
                reco.setTranslation(CGPointZero, inView: reco.view)
            case .Ended,.Cancelled:
                if adv.jr_y < 10 {
                    UIView.animateWithDuration(0.25, animations: { 
                        adv.jr_y = -adv.jr_height
                        }, completion: { (flag) in
                            self!.state = .Default
                    })
                }
            default:break
            }

        }.addDisposableTo(self.getDisposeBag())
    }

}
