//
//  AddView.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/27.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import BlocksKit
import SDAutoLayout

class AddView: UIView {
    
    var waveView: WaveView!
    var waveContainer: UIView!
    var timer: NSTimer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - public
    func startWave() {
        waveView.beginWave()
        _beginTimer()
    }
    
    func stopWave() {
        waveView.stopWave()
        _stopTimer()
    }
    
    
    
    // MARK: - private
    private func _setupUI() {
        
        waveContainer = UIView()
        waveContainer.clipsToBounds = true
        waveContainer.sd_cornerRadiusFromWidthRatio = 0.5
        waveContainer.userInteractionEnabled = false
        self.addSubview(waveContainer)
        
        waveView = WaveView()
        waveView.createWave(UIColor.blackColor().CGColor, waveWith: 100, height: 100, skwing: 40, amplitude: 3, speed: 4)
        waveView.userInteractionEnabled = false
        waveContainer.addSubview(waveView)
        
        waveContainer.sd_layout().spaceToSuperView(UIEdgeInsetsZero)
        waveView.sd_layout()
            .widthRatioToView(waveContainer, 1)
            .bottomEqualToView(waveContainer)
            .heightRatioToView(waveContainer, 0.5)
    }
    
    let interval: NSTimeInterval = 2
    private func _beginTimer() {
        timer?.invalidate()
        var flag = true
        timer = NSTimer.bk_scheduledTimerWithTimeInterval(interval, block: {[weak self] (timer) in
            self?.waveView.sd_layout().heightRatioToView(self!.waveContainer, flag ? 1 : 0.5)
            
            UIView.animateWithDuration(self!.interval, delay: 0, options: .CurveEaseOut, animations: {
                self?.waveView.updateLayout()
            }, completion: { (finished) in
                flag = !flag
            })
        }, repeats: true)
    }
    
    private func _stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
}
