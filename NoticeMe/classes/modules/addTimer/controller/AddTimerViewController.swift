//
//  AddTimerViewController.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/17.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import BlocksKit

class AddTimerViewController: UIViewController {
    
    var rx_end = PublishSubject<Bool>()
    
    var titleTextView: TitleTextView!
    var addingTimerView: AddingTimerView!
    
    var countDownModel: CountDownModel = CountDownModel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .Custom
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        titleTextView.textField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        
        setupUI()
        setupGesture()
        setupSignal()
    }
    
    func setupUI() {
        
        titleTextView = TitleTextView()
        titleTextView.jr_height = 50
        titleTextView.jr_width = view.jr_width - 30
        titleTextView.jr_x = 15
        titleTextView.jr_y = 30
        view.addSubview(titleTextView)
        
        addingTimerView = AddingTimerView()
        addingTimerView.frame.size = CGSizeMake(200, 200)
        addingTimerView.center = view.center
        addingTimerView.jr_y = titleTextView.jr_maxY + 80
        addingTimerView.timeLabel.text = countDownModel.intervalString
        view.addSubview(addingTimerView)
        
    }
    
    func setupGesture() {
        let swipe = UISwipeGestureRecognizer.init().bk_initWithHandler {[weak self] (reco, state, point) in
            self?.becomeFirstResponder()
            self?.dismissViewControllerAnimated(true, completion: nil)
        } as! UISwipeGestureRecognizer
        swipe.direction = .Up
        view.addGestureRecognizer(swipe)
        
        view.bk_whenTapped { [weak self] in
            self?.becomeFirstResponder()
        }
    }
    
    func setupSignal() {
        
        titleTextView.textField.rx_text.subscribeNext {[weak self] (text) in
            self?.countDownModel.title = text
        }.addDisposableTo(self.getDisposeBag())
        
        titleTextView.rx_doneClick.subscribeNext {[weak self] (text) in
            if text != nil && text?.characters.count > 0 {
                self?.saveCountDownModel()
            }
            self?.becomeFirstResponder()
            self?.rx_end.onNext(text != nil && text?.characters.count > 0)
        }.addDisposableTo(self.getDisposeBag())
        
        addingTimerView.rx_pan.subscribeNext {[weak self] (view: AddingTimerView, translatePoint: CGPoint) in
            
            self?.countDownModel.interval -= Double(translatePoint.y)
            self?.countDownModel.interval = max(self!.countDownModel.interval, 1)
            
            view.timeLabel.text = "\(self!.countDownModel.intervalString)"
            
        }.addDisposableTo(self.getDisposeBag())
    }
    
    func saveCountDownModel() {
        countDownModel.createDate = NSDate()
        countDownModel.jr_save()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
}
