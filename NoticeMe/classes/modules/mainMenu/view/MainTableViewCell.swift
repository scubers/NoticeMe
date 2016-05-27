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

class MainTableViewCell: BaseTableViewCell {

    var countDownModel: CountDownModel? {
        didSet {
            didSetCountDownModel()
        }
    }

    var titleLabel: UILabel!
    var timeLabel: UILabel!

    // MARK: - LifeCycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {

        titleLabel = UILabel()
        titleLabel.textAlignment = .Left
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.blackColor()
        contentView.addSubview(titleLabel)

        timeLabel = UILabel()
        timeLabel.textAlignment = .Left
        timeLabel.textColor = UIColor.lightGrayColor()
        contentView.addSubview(timeLabel)
        
        autolayout()
    }

    let topMargin: CGFloat = 5
    let leftMargin: CGFloat = 25
    func autolayout() {
        
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

    // MARK: - private method
    private func didSetCountDownModel() {
        titleLabel.text = countDownModel?.title
        timeLabel.text = countDownModel?.intervalString
        self.updateLayout()
    }
    
    // MARK: - other
    override func setHighlighted(highlighted: Bool, animated: Bool) {}
    override func setSelected(selected: Bool, animated: Bool) {}

    

}
