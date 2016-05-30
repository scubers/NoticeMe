//
//  AddingTimerView.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/17.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import RxSwift

class AddingTimerView: UIView {
    
    var waveView: WaveView!
    var timeLabel: UILabel!

    var rx_pan = PublishSubject<(view: AddingTimerView, translatePoint: CGPoint)>()
    
    // MARK: - lify cycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupUI()
        setupGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        timeLabel.frame = CGRectMake(0, 0, jr_width, 50)
        timeLabel.jr_centerY = jr_height / 2
        bringSubviewToFront(timeLabel)
    }
    
    // MARK: - private method
    
    private func setupUI() {
        waveView = WaveView()
        waveView.createWave(UIColor.whiteColor().CGColor, waveWith: 400, height: 300, skwing: 60, amplitude: 6, speed: 8)
        waveView.createWave(UIColor.blackColor().CGColor, waveWith: 400, height: 300, skwing: 40, amplitude: 5, speed: 6)
        addSubview(waveView)
        waveView.beginWave()
        waveView.jr_y = 80
        
        timeLabel = UILabel()
        timeLabel.textAlignment = .Center
        timeLabel.textColor = UIColor.yellowColor()
        timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        timeLabel.text = "3 : 00"
        addSubview(timeLabel)
        
    }
    
    private func setupGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(AddingTimerView.handlePan(_:)))
        addGestureRecognizer(pan)
    }
    
    @objc
    private func handlePan(reco: UIPanGestureRecognizer) {
        let p = reco.translationInView(reco.view)
        let y = waveView.jr_y + (p.y / 10)
        waveView.jr_y = min(y, jr_height)
        waveView.jr_y = max(y, -10)
        rx_pan.onNext((self, p))
        reco.setTranslation(CGPointZero, inView: reco.view)
    }
    
    // MARK: - public method
    func setProgress(progress: CGFloat, animated: Bool) {
        UIView.animateWithDuration(animated ? 0.2 : 0, delay: 0, options: .CurveEaseOut, animations: { 
            self.waveView.jr_y = self.jr_height * (1-progress)
            }) { (flag) in
                
        }
    }
    
    
    deinit {
        waveView.stopWave()
    }

}
