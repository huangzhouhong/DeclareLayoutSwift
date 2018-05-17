//
//  HStackLayout.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

open class HStackLayout: UICollectionViewLayout {
    var cache: [UICollectionViewLayoutAttributes] = []
    var preferredItemAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    public var itemSpacing: CGFloat = 0
    var desiredSize: CGSize = CGSize.zero

    open override func prepare() {
        guard let collectionView = collectionView else {
            return
        }

        cache.removeAll()
        var xPos: CGFloat = 0
        var desiredHeight: CGFloat = 0

        let layoutHeight = collectionView.frame.height - collectionView.contentInset.top - collectionView.contentInset.bottom
        SpeedLog.print("layoutHeight:\(layoutHeight)")

        for i in 0 ..< collectionView.numberOfItems(inSection: 0) {
            if i > 0 {
                xPos += itemSpacing
            }
            let indexPath = IndexPath(row: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            var itemWidth: CGFloat = 1
            var itemHeight: CGFloat = 1
            var yPos: CGFloat = 0

            if let preferredAttributes = preferredItemAttributes[indexPath] {
                SpeedLog.print("find prefer attribute:\(preferredAttributes.frame)")
                itemWidth = preferredAttributes.frame.width
                itemHeight = preferredAttributes.frame.height
                yPos = (layoutHeight - itemHeight) / 2
            } else {
                SpeedLog.print("use default cell size")
            }

            desiredHeight = max(desiredHeight, itemHeight)

            attribute.frame = CGRect(x: xPos, y: yPos, width: itemWidth, height: itemHeight)
            xPos += itemWidth

            cache.append(attribute)
        }

        desiredSize = CGSize(width: xPos, height: desiredHeight)
        SpeedLog.print("desiredSize:\(desiredSize)")
    }

    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        SpeedLog.print("rect:\(rect)")
        return cache
    }

    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        SpeedLog.print()
        return cache[indexPath.row]
    }

    open override var collectionViewContentSize: CGSize {
        SpeedLog.print("desiredSize:\(desiredSize)")
        return desiredSize
    }

    // item vertical center in UICollectionView
    // when size changed, invalidate layout
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else {
            return false
        }
        return collectionView.frame.size != newBounds.size
    }

    // MARK: -Self Sizing Cells

    open override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        if preferredAttributes.representedElementCategory == .cell {
            SpeedLog.print("originalAttributes:\(originalAttributes.frame)")
            SpeedLog.print("preferredAttributes:\(preferredAttributes.frame)")

            if preferredAttributes.frame.size != originalAttributes.frame.size {
                preferredItemAttributes[preferredAttributes.indexPath] = preferredAttributes
                return true
            } else {
                SpeedLog.print("ignore")
            }
        }
        return false
    }
}
