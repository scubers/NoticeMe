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
    
    var countDown: CountDownModel! {
        didSet {
            timeLabel?.text = countDown.restIntervalString
        }
    }
    var allowSwipeToDismiss: Bool = true
    var dismissSwipe: UISwipeGestureRecognizer!
    
    var timeLabel: UILabel!

    var displayLink: CADisplayLink?
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        view.bringSubviewToFront(timeLabel)
        setupNotification()
        setupLink()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        stopLink()
    }

    // MARK: - 子类方法
    /**
     子类实现
     - parameter progress: 进度
     */
    func updateCountDownProgress(progress: Double) {
        print("--------\(progress)----------")
    }

    func setupLink() {
        stopLink()
        displayLink = CADisplayLink(target: self, selector: #selector(BaseCountDownViewController.handleLink(_:)))
        displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }

    func stopLink() {
        if displayLink != nil {
            displayLink?.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            displayLink?.invalidate()
        }
    }

    func handleLink(link: CADisplayLink) {
        if countDown.startDate == nil {
            countDown.startDate = NSDate()
        }
        updateCountDownProgress(countDown.restInterval / countDown.interval)
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