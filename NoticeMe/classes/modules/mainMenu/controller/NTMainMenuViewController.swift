//
//  NTMainMenuViewController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import BlocksKit

class NTMainMenuViewController: NTViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = jr_randomColor()

        setupNavigationItems()

        let img = UIImage.imageWithColor(jr_rgbaColor(r: 200, g: 200, b: 200, a: 200)!, size: CGSizeMake(100, 100))

        let iv = UIImageView(image: img)

        view.addSubview(iv)

    }

    private func setupNavigationItems() {

        let item = UIBarButtonItem().bk_initWithTitle("进入详情", style: .Plain) { [weak self] (item) -> Void in

            self?.handleDetailWithItem(item as! UIBarButtonItem)

        } as! UIBarButtonItem


        let item2 = UIBarButtonItem().bk_initWithTitle("添加页面", style: .Plain) { [weak self] (item) -> Void in

            self?.handleAddWith(item as! UIBarButtonItem)

            } as! UIBarButtonItem

        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.leftBarButtonItem = item2
    }

    private func handleDetailWithItem(item:UIBarButtonItem) {
        self.navigationController?.pushViewController(NTWelcomeViewController(), animated: true)
    }

    private func handleAddWith(item:UIBarButtonItem) {
        presentViewController(NTAddTimerViewController(), animated: true) { () -> Void in
            
        }
    }


}
