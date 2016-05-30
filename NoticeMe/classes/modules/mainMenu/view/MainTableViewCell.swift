//
//  MainTableViewCell.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import SDAutoLayout
import JRUtils
import BlocksKit
import MGSwipeTableCell

private let maxEditViewWidth: CGFloat = 50

class MainTableViewCell: MGSwipeTableCell {

//    var containerView: UIView!

    typealias DeleteBlock = (cell: MainTableViewCell) -> Void
    typealias EditBlock = (cell: MainTableViewCell) -> Void

    var deleteBlock: DeleteBlock?
    var editBlock: EditBlock?

    var countDownModel: CountDownModel? {
        didSet {
            _didSetCountDownModel()
        }
    }

    var titleLabel: UILabel!
    var timeLabel: UILabel!

    // MARK: - LifeCycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setupUI()
        _setupButtons()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - private method
    private func _setupUI() {
        
//        containerView = UIView()
//        contentView.addSubview(containerView)

        titleLabel = UILabel()
        titleLabel.textAlignment = .Left
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.blackColor()
        contentView.addSubview(titleLabel)
        
        timeLabel = UILabel()
        timeLabel.textAlignment = .Left
        timeLabel.textColor = UIColor.lightGrayColor()
        contentView.addSubview(timeLabel)
        
        _autolayout()
    }
    
    let topMargin: CGFloat = 3
    let leftMargin: CGFloat = 25
    private func _autolayout() {
        
//        containerView.sd_layout()
//            .spaceToSuperView(UIEdgeInsetsZero)

        titleLabel.sd_layout()
            .leftSpaceToView(titleLabel.superview!, leftMargin)
            .rightSpaceToView(titleLabel.superview!, leftMargin)
            .topSpaceToView(titleLabel.superview!, topMargin)
            .autoHeightRatio(0)


        timeLabel.sd_layout()
            .leftEqualToView(titleLabel)
            .rightEqualToView(titleLabel)
            .topSpaceToView(titleLabel, topMargin)
            .autoHeightRatio(0)
        
        self.setupAutoHeightWithBottomView(timeLabel, bottomMargin: 0)
    }
    
    private func _setupButtons() {
        rightButtons = [

            _createButton(nil, image: UIImage(named: "flurries"), block: {[weak self] (cell) -> Bool in
                self?.deleteBlock?(cell: self!)
                return true
            }),
            _createButton(nil, image: UIImage(named: "fog"), block: {[weak self] (cell) -> Bool in
                self?.editBlock?(cell: self!)
                return true
            }),
        ]
        
    }
    
    private func _createButton(title: String!, image: UIImage!, block: MGSwipeButtonCallback!) -> MGSwipeButton {
        let button = MGSwipeButton(title: title, icon: image, backgroundColor: UIColor.clearColor(), callback: block)
        button.titleLabel?.textColor = UIColor.blackColor()
        return button
    }
    
    private func _didSetCountDownModel() {
        titleLabel.text = countDownModel?.title
        timeLabel.text = countDownModel?.intervalString
//        contentView.updateLayout()
    }
    
    // MARK: - other
    override func setHighlighted(highlighted: Bool, animated: Bool) {}
    override func setSelected(selected: Bool, animated: Bool) {}

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        print("titlelabel = \(titleLabel.frame)")
//        print("timeLabel = \(timeLabel.frame)")
//
//    }

}

