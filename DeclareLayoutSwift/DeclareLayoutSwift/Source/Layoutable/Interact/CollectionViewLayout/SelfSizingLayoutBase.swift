//
//  DLLayoutBase.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/5/4.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

open class SelfSizingLayoutBase: UICollectionViewLayout {
    var measure: Bool = false
    var availableSize: DLSize = DLSize.zero

    var cache: [UICollectionViewLayoutAttributes] = []
    var preferredItemAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    var contentSize: CGSize = CGSize.zero

    open override func prepare() {
        guard collectionView != nil else {
            return
        }

        cache.removeAll()

        if measure {
            prepareMeasure()
        } else {
            prepareArrange()
        }
    }

    open func prepareMeasure() {
        fatalError("use subclass")
    }

    open func prepareArrange() {
        fatalError("use subclass")
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
        SpeedLog.print("desiredSize:\(contentSize)")
        return contentSize
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
