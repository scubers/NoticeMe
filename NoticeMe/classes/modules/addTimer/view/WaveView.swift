//
//  WaveView.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/18.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import BlocksKit

class WaveModel {
    var width: CGFloat = 0
    var height: CGFloat = 0
    var skwing: CGFloat = 40
    var amplitude: CGFloat = 5
    var waveSpeed: CGFloat = 2
    
    init(width w: CGFloat = 0, height h: CGFloat = 0, skwing: CGFloat = 40, amplitude: CGFloat = 5, waveSpeed speed: CGFloat = 2) {
        self.width     = w
        self.height    = h
        self.skwing    = skwing
        self.amplitude = amplitude
        self.waveSpeed = speed
    }
}

class WaveView: UIView {

    var waves = [CAShapeLayer]()
    var waveModels = [WaveModel]()
    var displayLink: CADisplayLink?
    
    var radian: CGFloat = 0
    
    var maxWaveWidth: CGFloat = CGFloat(MAXFLOAT)
    var waveMoveSkwing: CGFloat = 2
    var waveSpeed: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearWaves() {
        displayLink?.invalidate()
        displayLink = nil
        waves.forEach {$0.removeFromSuperlayer()}
        waves.removeAll()
        waveModels.removeAll()
    }
    
    func createWave(color: CGColor, waveWith width: CGFloat, height: CGFloat, skwing: CGFloat, amplitude: CGFloat, speed: CGFloat) {
        
        let wave = CAShapeLayer()
        wave.fillColor = color
        let model = WaveModel(width: width, height: height, skwing: skwing, amplitude: amplitude, waveSpeed: speed)
        
        wave.path = generatePath(model, radian: radian).CGPath
        
        waveModels.append(model)
        waves.append(wave)
        layer.addSublayer(wave)
        
        
    }
    
    func generatePath(waveModel: WaveModel, radian r: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath()
        let beginR = r
        let endR = waveModel.width + r
        
        path.moveToPoint(CGPointMake(0, getYWith(beginR, waveModel: waveModel)))
        for i in Int(beginR+1)...Int(endR) {
            path.addLineToPoint(CGPointMake(CGFloat(i - Int(beginR)), getYWith(CGFloat(i), waveModel: waveModel)))
        }
        path.addLineToPoint(CGPointMake(waveModel.width, waveModel.height))
        path.addLineToPoint(CGPointMake(0, waveModel.height))
        path.addLineToPoint(CGPointMake(0, getYWith(beginR, waveModel: waveModel)))
        
        return path
    }
    
    func getYWith(r: CGFloat, waveModel: WaveModel) -> CGFloat {
        return sin(r / waveModel.skwing) * (cos(r / waveModel.skwing) * waveModel.amplitude)
    }
    
    
    
    func beginWave() {
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(WaveView.changingWavePath(_:)))
            displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        }
    }
    
    func stopWave() {
        displayLink?.invalidate()
    }
    
    
    func changingWavePath(link: CADisplayLink) {
        if self.superview == nil {
            link.invalidate()
            link.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            return
        }
        
        for (idx, ly) in waves.enumerate() {
            let model = waveModels[idx]
            ly.path = generatePath(model, radian: (radian * model.waveSpeed)).CGPath
        }
        radian += 1
    }
}
