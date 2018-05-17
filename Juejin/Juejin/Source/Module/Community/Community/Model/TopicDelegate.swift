//
//  TopicDelegate.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/20.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

fileprivate let headerItemHeight: CGFloat = 120
fileprivate let headerPadding: CGFloat = 12
fileprivate let headerItemWidth: CGFloat = UIScreen.main.bounds.width - 60

class TopicHeaderDelegate: NSObject, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegate {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = Image(.width <- headerItemWidth, .height <- headerItemHeight) {
            $0.image = #imageLiteral(resourceName: "banner1")
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
        }

        return collectionView.makeCell(element: element, indexPath: indexPath)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        SpeedLog.print(velocity)
        let collectionView = scrollView as! UICollectionView

        if let scrollToCell = findScrollToCell(collectionView: collectionView, velocityX: velocity.x) {
            let x = scrollToCell.frame.minX - (collectionView.frame.width - scrollToCell.frame.width) / 2
            SpeedLog.print("x:\(x)")
            targetContentOffset.pointee.x = x
        }
    }

    func findScrollToCell(collectionView: UICollectionView, velocityX: CGFloat) -> UICollectionViewCell? {
        var visibleCells = collectionView.visibleCells
        let currentOffset = collectionView.contentOffset.x

        visibleCells.sort { (cell1, cell2) -> Bool in
            if let indexPath1 = collectionView.indexPath(for: cell1),
                let indexPath2 = collectionView.indexPath(for: cell2) {
                if velocityX < 0 {
                    return indexPath1.row < indexPath2.row
                } else if velocityX > 0 {
                    return indexPath1.row > indexPath2.row
                } else {
                    return abs(currentOffset - cell1.frame.minX) < abs(currentOffset - cell2.frame.minX)
                }
            }
            return true
        }

        return visibleCells.first
    }
}

class TopicDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    func setupHeader(table: Table) {
        let headerDelegate = TopicHeaderDelegate()

        let header = Items(.height <- headerItemHeight + headerPadding * 2) {
            $0.delegate = headerDelegate
            $0.dataSource = headerDelegate
            $0.backgroundColor = .white
            $0.contentInset = Insets(headerPadding)
            $0.showsHorizontalScrollIndicator = false
            let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
            layout.scrollDirection = .horizontal
        }

        headerDelegate.retain(owner: header)

        table.header = header
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        let element = Label { $0.text = "test" }

        return tableView.makeCell(element: element)
    }
}
