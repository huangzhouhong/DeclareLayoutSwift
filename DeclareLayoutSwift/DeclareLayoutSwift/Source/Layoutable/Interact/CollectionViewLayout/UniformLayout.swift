//
//  UniformLayout.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/5/6.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

open class UniformLayout: SelfSizingLayoutBase {
    public var columnCount: Int?

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

        let columnCount = self.columnCount ?? itemCount
        let rowCount = Int(ceil(CGFloat(itemCount) / CGFloat(columnCount)))

        for index in 0 ..< itemCount {
            let indexPath = IndexPath(row: index, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = CGRect(x: 0, y: 0, width: cellSize.width, height: cellSize.height)
            cache.append(attribute)
        }

        contentSize = CGSize(width: cellSize.width * CGFloat(columnCount), height: cellSize.height * CGFloat(rowCount))
    }

    open override func prepareArrange() {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        guard itemCount != 0 else {
            return
        }

        let columnCount = self.columnCount ?? itemCount
        let rowCount = Int(ceil(CGFloat(itemCount) / CGFloat(columnCount)))

        let cellWidth = collectionView!.frame.width / CGFloat(columnCount)
        let cellHeight = collectionView!.frame.height / CGFloat(rowCount)

        for index in 0 ..< itemCount {
            let columnIndex = index % columnCount
            let rowIndex = Int(floor(CGFloat(index) / CGFloat(columnCount)))
            let x = cellWidth * CGFloat(columnIndex)
            let y = cellHeight * CGFloat(rowIndex)

            let indexPath = IndexPath(row: index, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
            cache.append(attribute)
        }

        contentSize = collectionView!.frame.size
    }

//    private func prepareForCellSize(_ size: CGSize) {
//        let itemCount = collectionView!.numberOfItems(inSection: 0)
//        guard itemCount != 0 else {
//            return
//        }
//
//        let columnCount = self.columnCount ?? itemCount
//        let rowCount = Int(ceil(CGFloat(itemCount) / CGFloat(columnCount)))
//
//        let cellWidth = size.width
//        let cellHeight = size.height
//
//        for index in 0 ..< itemCount {
//            let columnIndex = index % columnCount
//            let rowIndex = Int(floor(CGFloat(index) / CGFloat(columnCount)))
//            let x = cellWidth * CGFloat(columnIndex)
//            let y = cellHeight * CGFloat(rowIndex)
//
//            let indexPath = IndexPath(row: index, section: 0)
//            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//            attribute.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
//            cache.append(attribute)
//        }
//
//        contentSize = CGSize(width: cellWidth * CGFloat(columnCount), height: cellHeight * CGFloat(rowCount))
//    }

    open override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        if measure && preferredAttributes.indexPath == IndexPath(row: 0, section: 0) {
            return super.shouldInvalidateLayout(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
        } else {
            return false
        }
    }
}
