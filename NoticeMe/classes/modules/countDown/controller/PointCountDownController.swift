//
//  PointCountDownController.swift
//  NoticeMe
//
//  Created by JMacMini on 16/5/20.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import JRUtils

class PointCountDownController: BaseCountDownViewController {
    
    
    override func updateCountDownProgress(progress: Double) {
        super.updateCountDownProgress(progress)

        animate(UIColor.jr_randomColor(),
                point: CGPointMake(CGFloat(arc4random_uniform(UInt32(view.jr_width))), CGFloat(arc4random_uniform(UInt32(view.jr_height)))),
                initialSize: CGSizeMake(1, 1),
                endSize: randomSize(CGSizeMake(400, 400)))
        jr_delay(0.5, queue: dispatch_get_main_queue()) {
            self.animate(UIColor.jr_randomColor(),
                         point: CGPointMake(CGFloat(arc4random_uniform(UInt32(self.view.jr_width))), CGFloat(arc4random_uniform(UInt32(self.view.jr_height)))),
                         initialSize: CGSizeMake(1, 1),
                         endSize: self.randomSize(CGSizeMake(400, 400)))
        }
        
        
        view.bringSubviewToFront(timeLabel)
    }
    
    func randomSize(maxSize: CGSize) -> CGSize {
        let length = CGFloat(arc4random_uniform(UInt32(maxSize.width)))
        return CGSizeMake(length, length)
    }
    
    // MARK: - 动画方法
    func animate(color: UIColor, point: CGPoint, initialSize: CGSize, endSize: CGSize) {
        let circle = createCircleView(color, size: initialSize, point: point)
        view.addSubview(circle)
        
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: { 
            circle.alpha = 0
            circle.transform = CGAffineTransformMakeScale(endSize.width / (initialSize.width == 0 ? 1 : initialSize.width), endSize.height / (initialSize.height == 0 ? 1 : initialSize.height))
            }) { (finished) in
            circle.removeFromSuperview()
        }
    }
    
    func createCircleView(color: UIColor, size: CGSize, point: CGPoint) -> UIView {
        let circle = UIView()
        circle.frame.size = size
        circle.frame.origin = CGPointMake(point.x - size.width / 2, point.y - size.height / 2)
        let shape = CAShapeLayer()
        shape.fillColor = color.CGColor
        let path = UIBezierPath(ovalInRect: circle.bounds)
        shape.path = path.CGPath
        circle.layer.addSublayer(shape)
        return circle
    }
    
}
