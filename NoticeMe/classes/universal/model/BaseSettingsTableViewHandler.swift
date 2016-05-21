//
//  BaseSettingsTableViewHandler.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/2.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import SnapKit
import JRUtils

enum BaseSettingsItemType {
    case None
    case DisclosureIndicator
    case DetailDisclosureButton
    case Checkmark
    case Customize
    case AllCustomize
}


class BaseSettingsGroup : NSObject {
    lazy var items : [BaseSettingsItem] = Array()

    var heightForHeader: CGFloat = 0
    var heightForFooter: CGFloat = 0

    var titleForHeader: String?
    var titleForFooter: String?
}

class BaseSettingsItem : NSObject {

    typealias ActionBlock = (tableView: UITableView, indexPath: NSIndexPath) -> Void

    var actionBlock: ActionBlock?

    var reuseId: String?

    var titleText: String?
    var titleTextFont: UIFont?
    var titleTextColor: UIColor?

    var detailText: String?
    var detailTextFont: UIFont?
    var detailTextColor: UIColor?

    var heightForCell: CGFloat = 0

    var img: String?
    var image: UIImage?
    var imageUrl: NSURL?

    var hideSeperateLine: Bool = false
    var tag: Int = 0
    var accessoryView: UIView?
    var baseBackgroundView: UIView?

    var settingsType: BaseSettingsItemType = .None

    var clearHighLight: Bool = false

}


class BaseSettingsTableViewHandler: NSObject {
    
    var tableView: UITableView!
    
    convenience init(tableView: UITableView) {
        self.init()
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    lazy var groups : [BaseSettingsGroup] = Array()

    func listItemsWithReuseId(id: String) -> [NSIndexPath : BaseSettingsItem] {
        var result = [NSIndexPath : BaseSettingsItem]()

        for i in 0..<groups.count {
            let group = groups[i]
            for j in 0..<group.items.count {
                let item = group.items[j]
                if item.reuseId == id {
                    result[NSIndexPath(forRow: j, inSection: i)] = item
                }
            }

        }
        return result
    }

    func replaceItemsWithReuseId(id: String, item: BaseSettingsItem) -> [NSIndexPath]? {
        var dict = listItemsWithReuseId(id)
        if dict.count == 0 {return nil}

        var array: [NSIndexPath] = Array()
        dict.forEach { (indexPath, oldItem) in
            dict[indexPath] = item
            array.append(indexPath)
        }
        return array
    }

    func itemAtIndexPath(indexPath: NSIndexPath) -> BaseSettingsItem? {
        if indexPath.section >= groups.count {return nil}
        if indexPath.row >= groups[indexPath.section].items.count {return nil}
        return groups[indexPath.section].items[indexPath.row]
    }

}

class NTBaseView : UIView {}

class NTBaseSettingsTableViewCell : UITableViewCell {

    static func cellWithTableView(tableView: UITableView, identifier: String) -> NTBaseSettingsTableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(identifier) {
            return cell as! NTBaseSettingsTableViewCell
        }
        return NTBaseSettingsTableViewCell(style: .Default, reuseIdentifier: identifier)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var item: BaseSettingsItem? {
        didSet {
            didSetItem(item!)
        }
    }

    var separator: UIView!

    func setupSubviews() {
        separator = UIView()
        separator.backgroundColor = UIColor.jr_fullRgbaColor(r: 214, g: 214, b: 214, a: 1)
        contentView.addSubview(separator)
    }

    func didSetItem(newItem: BaseSettingsItem) {
        if newItem.img != nil {
            imageView?.image = UIImage(named: newItem.img!)
        } else if newItem.image != nil {
            imageView?.image = newItem.image
        }

        // 设置属性
        textLabel?.text       = newItem.titleText ?? ""
        detailTextLabel?.text = newItem.detailText ?? ""

        if let font = newItem.titleTextFont {textLabel?.font = font}
        if let color = newItem.titleTextColor {textLabel?.textColor = color}

        if let font = newItem.detailTextFont {detailTextLabel?.font = font}
        if let color = newItem.detailTextColor {detailTextLabel?.textColor = color}

        accessoryView         = newItem.accessoryView;

        switch newItem.settingsType {
        case .DisclosureIndicator:
            accessoryType = .DisclosureIndicator
        case .DetailDisclosureButton:
            accessoryType = .DetailDisclosureButton
        case .Checkmark:
            accessoryType = .Checkmark
        case .AllCustomize:
            contentView.subviews.forEach({ view in
                if view.isKindOfClass(NTBaseView.self) {
                    view.removeFromSuperview()
                }
            })

            let view = NTBaseView()
            contentView.addSubview(view)
            view.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(view.superview!)
            })

            view.addSubview(newItem.baseBackgroundView!)
            newItem.baseBackgroundView!.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(view)
            })
        default:
            accessoryType = .None
        }

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        separator.frame = CGRectMake(0, frame.height - 0.5, frame.width, 0.5)

        if let i = item {
            separator.hidden = i.hideSeperateLine
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        if !item!.clearHighLight {super.setSelected(selected, animated: animated)}
    }

    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if !item!.clearHighLight {super.setHighlighted(highlighted, animated: animated)}
    }

}

extension BaseSettingsTableViewHandler : UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = groups[indexPath.section].items[indexPath.row]

        if let block = item.actionBlock {
            block(tableView: tableView, indexPath: indexPath)
        }
    }


}

extension BaseSettingsTableViewHandler : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return groups.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groups.count == 0 { return 0}
        return groups[section].items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = groups[indexPath.section].items[indexPath.row]
        var ID = item.reuseId
        if ID == nil {
            ID = NTBaseSettingsTableViewCell.self.description()
        }
        let cell = NTBaseSettingsTableViewCell.cellWithTableView(tableView, identifier: ID!)
        cell.item = item
        return cell

    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = groups[indexPath.section].items[indexPath.row]
        return item.heightForCell
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < groups.count {
            return groups[section].heightForHeader
        }
        return 0
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < groups.count {
            return groups[section].heightForFooter
        }
        return 0
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < groups.count {
            return groups[section].titleForHeader
        }
        return nil
    }

    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section < groups.count {
            return groups[section].titleForFooter
        }
        return nil
    }

}
