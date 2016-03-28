//
//  NTMainMenuViewController.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/3/28.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class NTMainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = jr_randomColor()


    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        self.navigationController?.pushViewController(NTWelcomeViewController(), animated: true)


    }

}
