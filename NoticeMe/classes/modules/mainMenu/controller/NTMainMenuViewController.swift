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

    lazy var menuViewModel = NTMainMenuViewModel()

    var mainMenuView: NTMainMenuView?

    private var baseMenuFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupNavigationItems()

        setupSubviews()

    }

    private var driven: UIPercentDrivenInteractiveTransition? = UIPercentDrivenInteractiveTransition()

    private func setupSubviews() {
        let height: CGFloat = 200
        let rect = CGRectMake(0, view.frame.height - height, view.frame.width, height)
        baseMenuFrame = rect
        mainMenuView = NTMainMenuView(frame: rect)

        mainMenuView?.dataSource = menuViewModel

        view.addSubview(mainMenuView!)

        mainMenuView?.rx_onPan().subscribeNext({[weak self] (reco: UIGestureRecognizer) in
            print(reco.locationInView(self!.view))

            let re = reco as! UIPanGestureRecognizer


            let progress: CGFloat = -re.translationInView(self!.view).y / self!.view.height

            print("\(progress)======")

            switch reco.state {
            case .Began:

                let vc = NTCountDownViewController()
                CustomPresent.shareInstance.gestureDriven = UIPercentDrivenInteractiveTransition()
                self!.presentViewController(vc, animated: true, completion: nil)

            case .Changed:
                CustomPresent.shareInstance.gestureDriven?.updateInteractiveTransition(progress)

            case .Ended, .Cancelled: print("")

                UIView.animateWithDuration(0.3, delay: 0, options: [.CurveEaseOut], animations: {
                    self!.mainMenuView?.frame = self!.baseMenuFrame!
                    self?.mainMenuView?.userInteractionEnabled = false

                    }, completion: { (success) in
                        self?.mainMenuView?.userInteractionEnabled = true

                })
                CustomPresent.shareInstance.gestureDriven?.finishInteractiveTransition()
            default: print("")
            }

        }).addDisposableTo(getDisposeBag())

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
        self.navigationController?.pushViewController(NTCountDownViewController(), animated: true)
    }

    private func handleAddWith(item:UIBarButtonItem) {

        presentViewController(NTAddTimerViewController(), animated: true) { () -> Void in
            
        }
    }


}
