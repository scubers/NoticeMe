//
//  MainViewController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import SDAutoLayout
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
    
    var addView: AddView!
    
    var state: MainViewState = .Default

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        _setupUI()
        _setupSignal()
        
        RZTransitionsManager.shared().setAnimationController(AddTimerAnimator(), fromViewController: self.dynamicType, forAction: .PresentDismiss)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        addView.startWave()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        addView.stopWave()
    }

    // MARK: - private
    private func _setupUI() {
        tableView = UITableView(frame: view.bounds, style: .Plain)
        view.addSubview(tableView)
        tableViewHandler = MainTableViewHandler(tableView: tableView)
        
        addView = AddView()
        view.addSubview(addView)
        addView.sd_layout()
            .widthIs(50)
            .heightEqualToWidth()
            .rightSpaceToView(addView.superview!, 30)
            .bottomSpaceToView(addView.superview!, 50)
        addView.startWave()
        
        addView.bk_whenTapped { [weak self]  in
            self?.presentViewController(self!._getAddTimerController(), animated: true, completion: nil)
        }
    }
    
    private func _setupSignal() {
        
        tableViewHandler
            .rx_selecteModel
            .subscribeNext {[weak self] (model: CountDownModel, indexpath: NSIndexPath) in
                if let clazz = model.animationTypeEnum.getClazz() as? BaseCountDownViewController.Type {
                    let vc: BaseCountDownViewController = clazz.init()
                    model.startDate = NSDate() + 1
                    vc.countDown = model
                    self!.presentViewController(vc, animated: true, completion: nil)
                }
            }.addDisposableTo(self.getDisposeBag())
        
    }
    
    private func _getAddTimerController() -> AddTimerViewController {
        let nextViewController = AddTimerViewController()
        nextViewController.transitioningDelegate = RZTransitionsManager.shared()
        
        nextViewController.rx_end.subscribeNext {[weak self] (saved) in
            self?.tableViewHandler.reloadModels()
            self?.dismissViewControllerAnimated(true, completion: nil)
        }.addDisposableTo(self.getDisposeBag())

        return nextViewController
    }

}

