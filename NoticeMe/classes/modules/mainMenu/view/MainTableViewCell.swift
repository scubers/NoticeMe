//
//  MainTableViewCell.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/5/8.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import SnapKit
import JRUtils

class MainTableViewCell: BaseTableViewCell {

    var countDownModel: CountDownModel? {
        didSet {
            titleLabel.text = countDownModel?.title
            timeLabel.text = countDownModel?.interval?.description
            setNeedsUpdateConstraints()
        }
    }

    var titleLabel: UILabel!
    var timeLabel: UILabel!

    // MARK: - LifeCycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
//        clipsToBounds = true

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        jr_block {
            titleLabel = UILabel()
            titleLabel.textAlignment = .Left
            titleLabel.numberOfLines = 0
            titleLabel.textColor = UIColor.blackColor()
            contentView.addSubview(titleLabel)
        }

        jr_block {
            timeLabel = UILabel()
            timeLabel.textAlignment = .Left
            timeLabel.textColor = UIColor.lightGrayColor()
            contentView.addSubview(timeLabel)
        }
        autolayout()
    }

    let topMargin: CGFloat = 5
    let leftMargin: CGFloat = 25
    func autolayout() {
        contentView.bounds = CGRectMake(0, 0, 9999, 9999)
        titleLabel.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(titleLabel.superview!).inset(EdgeInsets(top: topMargin, left: leftMargin, bottom: 0, right: leftMargin))
        }
        timeLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(15)
            make.top.equalTo(titleLabel.snp_bottom).offset(topMargin)
            make.bottom.equalTo(timeLabel.superview!).offset(-topMargin)
        }
        
    }

    override func updateConstraints() {

        let maxSize = CGSizeMake((appDelegate()?.window?.frame.width)! - 2 * topMargin, CGFloat(MAXFLOAT))
        let size = NSString(string: titleLabel.text ?? "").boundingRectWithSize(maxSize, options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: [
            NSFontAttributeName : titleLabel.font
            ], context: nil).size

        titleLabel.snp_updateConstraints { (make) in
            make.height.equalTo(floor(size.height) + 10)
        }
        super.updateConstraints()

    }

    override func setHighlighted(highlighted: Bool, animated: Bool) {}
    override func setSelected(selected: Bool, animated: Bool) {}


}
