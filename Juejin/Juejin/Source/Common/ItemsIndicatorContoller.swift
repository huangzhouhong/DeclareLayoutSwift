//
//  ItemsIndicatorContoller.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/23.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

class ItemsIndicatorContoller {
    let indicatorView: UIView
    let collectionView: UICollectionView
    var indicatorHeight: CGFloat = 4
    var indicatorColor: UIColor = .red {
        didSet {
            indicatorView.backgroundColor = indicatorColor
        }
    }

    init(collectionView: UICollectionView) {
        indicatorView = UIView()
        indicatorView.backgroundColor = indicatorColor

        self.collectionView = collectionView
        collectionView.addSubview(indicatorView)
    }

    func setCurrentItemIndex(_ currentItemIndex: CGFloat) {
        let leftItemIndex = floor(currentItemIndex)
        let rightItemIndex = ceil(currentItemIndex)

        let leftCell = collectionView.cellForItem(at: IndexPath(row: Int(leftItemIndex), section: 0))
        let rightCell = collectionView.cellForItem(at: IndexPath(row: Int(rightItemIndex), section: 0))

        if let leftCell = leftCell, let rightCell = rightCell {
            let leftRect = leftCell.convert(leftCell.bounds, to: collectionView)
            let rightRect = rightCell.convert(rightCell.bounds, to: collectionView)

            let x = leftRect.minX + (rightRect.minX - leftRect.minX) * (currentItemIndex - leftItemIndex)
            let y: CGFloat = collectionView.frame.height - indicatorHeight
            let rightPercent = currentItemIndex - leftItemIndex
            let width: CGFloat = leftRect.width * (1 - rightPercent) + rightRect.width * rightPercent
            indicatorView.frame = CGRect(x: x, y: y, width: width, height: indicatorHeight)
        }
    }
}
