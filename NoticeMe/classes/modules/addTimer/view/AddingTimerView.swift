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
        backgroundColor = Colors.Wave.Background
        clipsToBounds = true
        _setupUI()
        _setupGesture()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        timeLabel.frame = CGRectMake(0, 0, jr_width, 50)
        timeLabel.jr_centerY = jr_height / 2
        bringSubviewToFront(timeLabel)
    }
    
    // MARK: - private method
    
    private func _setupUI() {
        waveView = WaveView()
        waveView.createWave(Colors.Wave.Color1.CGColor, waveWith: 400, height: 300, skwing: 60, amplitude: 6, speed: 8)
        waveView.createWave(Colors.Wave.Color2.CGColor, waveWith: 400, height: 300, skwing: 40, amplitude: 5, speed: 6)
        addSubview(waveView)
        waveView.beginWave()
        waveView.jr_y = 80
        
        timeLabel = UILabel()
        timeLabel.textAlignment = .Center
        timeLabel.textColor = Colors.White
        timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        timeLabel.text = "3 : 00"
        addSubview(timeLabel)
        
    }
    
    private func _setupGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(AddingTimerView._handlePan(_:)))
        addGestureRecognizer(pan)
    }
    
    @objc private func _handlePan(reco: UIPanGestureRecognizer) {
        let p = reco.translationInView(reco.view)
//        let y = waveView.jr_y + (p.y / 10)
//        waveView.jr_y = min(y, jr_height)
//        waveView.jr_y = max(y, -10)
        rx_pan.onNext((self, p))
        reco.setTranslation(CGPointZero, inView: reco.view)
    }
    
    // MARK: - public method
    func setProgress(progress: CGFloat, animated: Bool) {
        let progress = max(min(progress, 1), 0)
        print(progress)
        UIView.animateWithDuration(animated ? 0.35 : 0, delay: 0, options: .CurveEaseOut, animations: {
            self.waveView.jr_y = self.jr_height * (1-progress)
            self.waveView.jr_height = self.jr_height
            }) { (flag) in
                
        }
    }
    
    
    deinit {
        waveView.stopWave()
    }

}
