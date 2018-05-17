//
//  AutoScrollController.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/27.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

open class AutoScrollController :NSObject{
    weak var collectionView: UICollectionView?
    var timer: Timer?
    public var scrollDuration: TimeInterval

    public init(collectionView: UICollectionView, scrollDuration: TimeInterval = 3) {
        self.collectionView = collectionView
        self.scrollDuration = scrollDuration
        super.init()
        start()
    }

    public func start() {
        createTimer()
    }

    public func pause() {
        timer?.invalidate()
    }

    func createTimer() {
        timer?.invalidate()
        if scrollDuration > 0 {
            timer = Timer.scheduledTimer(withTimeInterval: scrollDuration, repeats: true) {
                [weak self] _ in
                self?.doScroll()
            }
        }
    }

    open func doScroll() {
        SpeedLog.print()
        guard let collectionView = collectionView else {
            SpeedLog.print("collection released")
            timer?.invalidate()
            return
        }
        guard collectionView.window != nil else {
            SpeedLog.print("collectionView currently no show")
            return
        }
        guard let dataSource = collectionView.dataSource else {
            SpeedLog.print("no dataSource")
            return
        }
        guard let nextIndexPath = getNextIndexPath(collectionView: collectionView) else {
            SpeedLog.print("get nextIndexPath fail")
            return
        }

        SpeedLog.print("nextIndexPath:\(nextIndexPath)")

        if nextIndexPath.row < dataSource.collectionView(collectionView, numberOfItemsInSection: 0) {
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }else{
            SpeedLog.print("nextIndexPath out of range")
        }
    }

    open func getNextIndexPath(collectionView: UICollectionView) -> IndexPath? {
        guard let currentIndexPath = getCurrentIndexPath(collectionView: collectionView) else {
            return nil
        }

        return IndexPath(row: currentIndexPath.row + 1, section: 0)
    }

    private func getCurrentIndexPath(collectionView: UICollectionView) -> IndexPath? {
        var visibleIndexPaths = collectionView.indexPathsForVisibleItems
        SpeedLog.print("visibleIndexPaths:\(visibleIndexPaths)")
        switch visibleIndexPaths.count {
        case 0:
            SpeedLog.print("no visible item")
            return nil
        case 1:
            return visibleIndexPaths.first
        default:
            visibleIndexPaths.sort()
            return visibleIndexPaths[(visibleIndexPaths.count - 1) / 2]
        }
    }
}
