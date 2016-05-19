//
//  MainViewController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import JRUtils
import FXBlurView
import RxSwift
import RxCocoa
import RZTransitions

enum MainViewState {
    case Default
    case Adding
}

class MainViewController: BaseViewController {

    var tableView: UITableView!
    var tableViewHandler: MainTableViewHandler!
    
    var state: MainViewState = .Default

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupUI()
        
        RZTransitionsManager.shared().setAnimationController(AddTimerAnimator(), fromViewController: self.dynamicType, forAction: .PresentDismiss)
        
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
        
        setupSignal()

    }
    
    private func setupSignal() {
        
        tableViewHandler
            .rx_show
            .subscribeNext {[weak self] (flag) in
                self?.presentViewController(self!.getAddTimerController(), animated:true) {}
            }.addDisposableTo(self.getDisposeBag())
        
        tableViewHandler
            .rx_selecteModel
            .subscribeNext {[weak self] (model: CountDownModel, indexpath: NSIndexPath) in
                self!.presentViewController(BaseCountDownViewController(countDownModel: model), animated: true, completion: nil)
            }.addDisposableTo(self.getDisposeBag())
    }
    
    func getAddTimerController() -> AddTimerViewController {
        let nextViewController = AddTimerViewController()
        nextViewController.transitioningDelegate = RZTransitionsManager.shared()
        
        nextViewController.rx_end.subscribeNext {[weak self] (saved) in
            self?.tableViewHandler.reloadModels()
            self?.dismissViewControllerAnimated(true, completion: nil)
        }.addDisposableTo(self.getDisposeBag())
        
        return nextViewController
    }

}

