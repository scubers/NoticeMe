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


private let AccelerometerUpdateInterval = 1/10.0

class BaseCountDownViewController: BaseViewController {

    
    var countDown: CountDownModel! {
        didSet {
            timeLabel?.text = countDown.restIntervalString
        }
    }

    // MARK: - options
    var allowSwipeToDismiss: Bool = true
    var needFullFrameUpdate: Bool = true {
        didSet {
            if needFullFrameUpdate {
                if isViewLoaded() && view.window != nil {
                    setupLink()
                }
            } else {
                stopLink()
            }
        }
    }

    // MARK: - controls
    var dismissSwipe: UISwipeGestureRecognizer!
    var timeLabel: UILabel!
    var displayLink: CADisplayLink?

    // MARK: - life cycle
    convenience init(countDownModel: CountDownModel) {
        self.init()
        countDown = countDownModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupUI()
        setupGesture()
        setupNotification()
    }
    
    private func setupUI() {
        timeLabel = UILabel()
        timeLabel.textAlignment = .Center
        timeLabel.backgroundColor = UIColor(white: 0.8, alpha: 0.4)
        timeLabel.text = countDown.restIntervalString
        timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        view.addSubview(timeLabel)
        
        timeLabel.sd_layout()
            .centerXEqualToView(timeLabel.superview!)
            .centerYEqualToView(timeLabel.superview!)
            .widthRatioToView(timeLabel.superview!, 2)
            .heightIs(40)
        
//        timeLabel.snp_makeConstraints { (make) in
//            make.center.equalTo(timeLabel.superview!)
//            make.height.equalTo(40)
//            make.width.equalTo(view.jr_height * 2)
//        }
        
    }
    
    private func setupNotification() {
        NSNotificationCenter
            .defaultCenter()
            .rx_notification(TimerBeatNotification, object: nil)
            .subscribeNext {[weak self] _ in
                self?.timeLabel.text = self?.countDown.restIntervalString
                if !self!.needFullFrameUpdate {
                    self?.updateCountDownProgress(self!.countDown.restInterval / self!.countDown.interval)
                }
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
        setupLink()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        stopLink()
//        motionMgr.stopAccelerometerUpdates()
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

        guard needFullFrameUpdate else {
            return
        }

        displayLink = CADisplayLink(target: self, selector: #selector(BaseCountDownViewController.handleLink(_:)))
        displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }

    /**
     屏幕转向

     - parameter angle: 屏幕垂直于水平面，正握手机为0度
     */
    func deviceOrientationChangedTo(angle: Double) {
        UIView.animateWithDuration(0.1) {
            self.timeLabel.transform = CGAffineTransformMakeRotation(CGFloat(angle))
        }
    }


    // MARK: - 动画定时器
    func stopLink() {
        if displayLink != nil {
            displayLink?.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            displayLink?.invalidate()
            displayLink = nil
        }
    }

    func handleLink(link: CADisplayLink) {
        if countDown.startDate == nil {
            countDown.startDate = NSDate()
        }
        updateCountDownProgress(countDown.restInterval / countDown.interval)
        if countDown.restInterval / countDown.interval == 0 {
            stopLink()
        }
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