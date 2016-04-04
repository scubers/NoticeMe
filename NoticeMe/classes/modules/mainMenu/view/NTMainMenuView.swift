//
//  NTMainMenuView.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/4.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import BlocksKit
import RxCocoa
import RxSwift

class NTMainMenuView: UICollectionView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSizeMake(50, frame.height)

        super.init(frame: frame, collectionViewLayout: layout)

        configure()
        setupGesture()
    }

    private var flag: Bool = true
    private var upAndDownPan: UIPanGestureRecognizer?

    // MARK: 初始化方法
    private func configure() {
        self.backgroundColor = UIColor.clearColor()
        self.registerClass(NTMainMenuCell.self, forCellWithReuseIdentifier: NTMainMenuCell.self.description())
        self.delegate = self
    }

    // MARK: 手势处理
    private func setupGesture() {
        let panUpAndDown = UIPanGestureRecognizer(target: self, action: #selector(NTMainMenuView.handlePanUpAndDown(_:)))
        panUpAndDown.delegate = self
        if upAndDownPan != nil{self.removeGestureRecognizer(upAndDownPan!)}
        self.addGestureRecognizer(panUpAndDown)
        upAndDownPan = panUpAndDown
    }
    @objc private func handlePanUpAndDown(reco: UIPanGestureRecognizer) {

        let point = reco.translationInView(reco.view)
        self.frame.origin.y += point.y
        reco.setTranslation(CGPointZero, inView: reco.view)

    }

    // MARK: 对外公开方法
    // MARK: 信号
    func rx_onPan() -> Observable<UIGestureRecognizer> {
        return (upAndDownPan?.rx_event.asObservable())!
    }

}

extension NTMainMenuView : UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == upAndDownPan {
            let reco = gestureRecognizer as! UIPanGestureRecognizer
            let point = reco.translationInView(reco.view)
            if abs(point.x) > 0 {return false}
        }
        return true
    }
}

extension NTMainMenuView : UICollectionViewDelegate {
}

class NTMainMenuCell: UICollectionViewCell {

}