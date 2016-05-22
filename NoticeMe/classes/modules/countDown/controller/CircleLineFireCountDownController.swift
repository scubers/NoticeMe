//
//  LineFireCountDownController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/22.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class CircleLineFireCountDownController: BaseCountDownViewController {

    var lineLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLine()
    }

    override func updateCountDownProgress(progress: Double) {
        super.updateCountDownProgress(progress)
        lineLayer.strokeEnd = CGFloat(progress)
    }


    let lineCorner = 1.0
    let lineMargin = 2.0
    var nowRadius = 0.0

    private func setupLine() {
        view.layer.addSublayer(lineLayer)

        lineLayer.strokeColor = UIColor.orangeColor().CGColor
        lineLayer.fillColor = UIColor.clearColor().CGColor

        lineLayer.lineWidth = 2

        lineLayer.strokeStart = 0
        lineLayer.strokeEnd = 1

        let path = UIBezierPath()

        path.moveToPoint(view.center)

        var angle = 0.0
        while CGFloat(nowRadius) < view.jr_width {
            angle += 0.5 / (2 * M_PI)
            let p = getPointWith(view.center, angle: angle)
            path.addLineToPoint(p)
            if p.x < 0 || p.x > view.jr_width || p.y < 0 || p.y > view.jr_height {
                break
            }
        }

        lineLayer.path = path.CGPath

    }

    private func getPointWith(center: CGPoint, angle: Double) -> CGPoint {
        nowRadius += lineMargin / (2 * M_PI)

        let x = center.x + CGFloat(nowRadius * cos(angle))
        let y = center.y + CGFloat(nowRadius * sin(angle))

        print("\(nowRadius)----\(angle)===\(x)---\(y)")

        return CGPointMake(x, y)
    }



}
