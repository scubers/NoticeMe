//
//  NTMainNavgationController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class NTMainNavgationController: UINavigationController {

    var alphaView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage.imageWithColor(UIColor.clearColor(), size: self.navigationBar.bounds.size)
        self.navigationBar.setBackgroundImage(img, forBarMetrics: .Compact)
        self.navigationBar.clipsToBounds = true

        alphaView.frame = CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height + 20)
        alphaView.backgroundColor = jr_randomColor()
        self.view.insertSubview(alphaView, belowSubview: self.navigationBar)

        self.navigationBar.addObserver(self, forKeyPath: "frame", options: [.New], context: nil)

    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            let rect = change?["new"] as! CGRect
            alphaView.frame = CGRectMake(rect.origin.x, rect.origin.y - 20, rect.size.width, rect.size.height)
        }
    }

    func setNavigationAlpha(alpah:CGFloat) {
        alphaView.alpha = alpah
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
