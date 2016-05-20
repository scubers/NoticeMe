//
//  BaseCountDownViewController.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/19.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import BlocksKit
import SnapKit

class BaseCountDownViewController: BaseViewController {
    
    var countDown: CountDownModel!
    var allowSwipeToDismiss: Bool = true
    var dismissSwipe: UISwipeGestureRecognizer!
    
    var timeLabel: UILabel!
    
    // MARK: - life cycle
    convenience init(countDownModel: CountDownModel) {
        self.init()
        countDown = countDownModel
        countDown.startDate = NSDate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupUI()
//        setupNotification()
        setupGesture()
    }
    
    private func setupUI() {
        timeLabel = UILabel()
        timeLabel.textAlignment = .Center
        timeLabel.backgroundColor = UIColor(white: 0.8, alpha: 0.4)
        timeLabel.text = countDown.restIntervalString
        timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        view.addSubview(timeLabel)
        
        timeLabel.snp_makeConstraints { (make) in
            make.left.right.centerY.equalTo(timeLabel.superview!)
            make.height.equalTo(40)
        }
        
    }
    
    private func setupNotification() {
        NSNotificationCenter
            .defaultCenter()
            .rx_notification(TimerBeatNotification, object: nil)
            .subscribeNext {[weak self] _ in
                
                if self?.countDown.startDate == nil {
                    self?.countDown.startDate = NSDate()
                }
                
                self?.updateCountDownProgress((1-self!.countDown.restInterval) / self!.countDown.interval)
                self?.timeLabel.text = self?.countDown.restIntervalString
                
            }.addDisposableTo(self.getDisposeBag())
    }
    
    private func setupGesture() {
        dismissSwipe = UISwipeGestureRecognizer.init().bk_initWithHandler {[weak self] (reco, state, point) in
            self?.dismissViewControllerAnimated(true, completion: nil)
        } as! UISwipeGestureRecognizer
        dismissSwipe.direction = .Down
        dismissSwipe.delegate = self
        
        view.addGestureRecognizer(dismissSwipe)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubviewToFront(timeLabel)
        setupNotification()
    }

    // MARK: - 子类方法
    /**
     子类实现
     - parameter progress: 进度
     */
    func updateCountDownProgress(progress: Double) {
        print("--------\(progress)----------")
    }
    
    
}

// MARK: - UIGestureRecognizerDelegate

extension BaseCountDownViewController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == dismissSwipe {
            return allowSwipeToDismiss
        }
        return true
    }
}