//
//  AddingTimerView.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/17.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class AddingTimerView: UIView {
    
    var waveLayers = [CAShapeLayer]()
    var testAnimation = UIView()
    var testLayer = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = UIColor.jr_randomColor()
        setupUI()
    }
    
    func setupUI() {
        addSubview(testAnimation)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
        startWave()
    }
    
    func startWave() {
//        waveLayers.forEach({$0.removeFromSuperlayer()})
//        waveLayers.removeAll()
        testLayer.removeFromSuperlayer()
        testLayer = CAShapeLayer()
        testLayer.fillColor = UIColor.blackColor().CGColor
        
        let maxW :CGFloat = 100000
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(maxW, jr_height / 2))
        path.addLineToPoint(CGPointMake(maxW, jr_height))
        path.addLineToPoint(CGPointMake(0, jr_height))
        path.addLineToPoint(CGPointMake(0, jr_height / 2))
        
        Int(maxW).jr_times { (i) in
            func getY(x:CGFloat) -> CGFloat {
                let r = x / 40
//                print(r)
                return (abs(r - 30)) * sin(r) + self.jr_height / 2
            }
//            print("\(CGPointMake(CGFloat(i), getY(CGFloat(i))))----");
            path.addLineToPoint(CGPointMake(CGFloat(i), getY(CGFloat(i))))
        }
//        path.fill()
        
        testLayer.path = path.CGPath
        testAnimation.layer.addSublayer(testLayer)
        
        UIView.animateWithDuration(100) {
            self.testAnimation.frame.origin.x = self.jr_width - maxW
        }
    }

}
