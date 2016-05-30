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
import BlocksKit
import JRUtils
import SDAutoLayout


class AddTimerViewController: UIViewController {
    
    var rx_end = PublishSubject<Bool>()
    
    var titleTextView: TitleTextView!
    var addingTimerView: AddingTimerView!
    
    var countDownModel: CountDownModel = CountDownModel()


    // MARK: - life cycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .Custom
    }

    convenience init(countDownModel: CountDownModel?) {
        self.init(nibName: nil, bundle: nil)
        if let countDownModel = countDownModel {
            self.countDownModel = countDownModel
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        titleTextView.textField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        
        _setupUI()
        _setupGesture()
        _setupSignal()
    }

    // MARK: - private
    private func _setupUI() {
        
        titleTextView = TitleTextView()
        titleTextView.textField.text = countDownModel.title
        view.addSubview(titleTextView)
        titleTextView.sd_layout()
            .topSpaceToView(view, 30)
            .leftSpaceToView(view, 15)
            .rightSpaceToView(view, 15)
            .heightIs(50)
        
        addingTimerView = AddingTimerView()
        addingTimerView.timeLabel.text = countDownModel.intervalString
        view.addSubview(addingTimerView)
        addingTimerView.sd_layout()
            .widthIs(200)
            .heightEqualToWidth()
            .centerXEqualToView(view)
            .centerYIs(view.jr_height * 0.4)
    }
    
    private func _setupGesture() {
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
    
    private func _setupSignal() {

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

    // MARK: - public

    func saveCountDownModel() {
        if countDownModel.ID() == nil && countDownModel.jr_customPrimarykeyValue() == nil {
            // save
            countDownModel.createDate = NSDate()
            countDownModel.jr_save()
        } else {
            // update
            countDownModel.updateDate = NSDate()
            countDownModel.jr_updateWithColumn(nil)
        }
    }



    // MARK: - Other
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
}
