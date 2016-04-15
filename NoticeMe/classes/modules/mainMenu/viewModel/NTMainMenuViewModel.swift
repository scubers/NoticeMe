//
//  NTMainMenuViewModel.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/4.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit
import MagicalRecord

class NTMainMenuViewModel: NSObject {
    var countDownModels: [NTCountDownModel]?
    lazy var context: NSManagedObjectContext = NSManagedObjectContext.MR_context()

    override init() {
        super.init()
        configureDataSource()
    }

    private func configureDataSource() {
        countDownModels = NTCountDownModel.MR_findAllInContext(context) as? [NTCountDownModel]
    }

    func reloadDataSource() {
        configureDataSource()
    }

}


extension NTMainMenuViewModel: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return countDownModels?.count
        return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NTMainMenuCell.self.description(), forIndexPath: indexPath)
        cell.contentView.backgroundColor = jr_randomColor()
        return cell
    }

    func configureCell(cell: UICollectionViewCell, forIndexPath indexPath: NSIndexPath) {

    }
}
