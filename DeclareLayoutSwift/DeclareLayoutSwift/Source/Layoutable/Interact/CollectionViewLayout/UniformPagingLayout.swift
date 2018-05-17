//
//  UniformPagingLayout.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/5/7.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

open class UniformPagingLayout: SelfSizingLayoutBase {
    public var eachPageColumnCount: Int?

    open override func prepareMeasure() {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        guard itemCount != 0 else {
            return
        }

        var cellSize: CGSize
        if let firstPageAttribute = preferredItemAttributes[IndexPath(row: 0, section: 0)] {
            cellSize = firstPageAttribute.frame.size
        } else {
            cellSize = CGSize(width: 1, height: 1)
        }

        for index in 0 ..< itemCount {
            let indexPath = IndexPath(row: index, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = CGRect(x: 0, y: 0, width: cellSize.width, height: cellSize.height)
            cache.append(attribute)
        }

        contentSize = CGSize(width: cellSize.width * CGFloat(itemCount), height: cellSize.height)
    }

    open override func prepareArrange() {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        guard itemCount != 0 else {
            return
        }

        let columnCount = self.eachPageColumnCount ?? itemCount
//        let rowCount = Int(ceil(CGFloat(itemCount) / CGFloat(columnCount)))

        let cellWidth = collectionView!.frame.width / CGFloat(columnCount)
        let cellHeight = collectionView!.frame.height

        for index in 0 ..< itemCount {
//            let columnIndex = index % columnCount
//            let rowIndex = Int(floor(CGFloat(index) / CGFloat(columnCount)))
//            let x = cellWidth * CGFloat(columnIndex)
//            let y = cellHeight * CGFloat(rowIndex)

            let indexPath = IndexPath(row: index, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = CGRect(x: cellWidth * CGFloat(index), y: 0, width: cellWidth, height: cellHeight)
            cache.append(attribute)
        }

        let pageCount = ceil(CGFloat(itemCount) / CGFloat(columnCount))
        contentSize = CGSize(width: collectionView!.frame.width * pageCount, height: collectionView!.frame.height)
    }

    open override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        if measure && preferredAttributes.indexPath == IndexPath(row: 0, section: 0) {
            return super.shouldInvalidateLayout(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        } else {
            return false
        }
    }
}
