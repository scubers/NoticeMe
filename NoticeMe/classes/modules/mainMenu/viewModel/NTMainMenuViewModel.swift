//
//  NTMainMenuViewModel.swift
//  NoticeMe
//
//  Created by 王俊仁 on 16/4/4.
//  Copyright © 2016年 王俊仁. All rights reserved.
//

import UIKit

class NTMainMenuViewModel: NSObject {

}


extension NTMainMenuViewModel: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NTMainMenuCell.self.description(), forIndexPath: indexPath)
        cell.contentView.backgroundColor = jr_randomColor()
        return cell
    }
}
