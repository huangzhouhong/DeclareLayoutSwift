//
//  PageLayout.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/26.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

// each item is one page
open class PageLayout: SelfSizingLayoutBase {
    open override func prepareMeasure() {
        if let firstPageAttribute = preferredItemAttributes[IndexPath(row: 0, section: 0)] {
            prepareForCellSize(firstPageAttribute.frame.size)
        } else {
            prepareForCellSize(CGSize(width: 1, height: 1))
        }
    }

    open override func prepareArrange() {
        prepareForCellSize(collectionView!.frame.size)
    }

    private func prepareForCellSize(_ size: CGSize) {
        var xPos: CGFloat = 0
        let cellWidth = size.width
        let cellHeight = size.height

        for index in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(row: index, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = CGRect(x: xPos, y: 0, width: cellWidth, height: cellHeight)
            cache.append(attribute)
            xPos += cellWidth
        }

        contentSize = CGSize(width: xPos, height: cellHeight)
    }

    open override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        if measure && preferredAttributes.indexPath == IndexPath(row: 0, section: 0) {
            return super.shouldInvalidateLayout(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        } else {
            return false
        }
    }
}
