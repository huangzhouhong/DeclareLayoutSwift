//
//  UICollectionViewInfiniteLoopHook.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/5/15.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import Aspects
import UIKit

public class UICollectionViewInfiniteLoopHook<T: NSObject & UICollectionViewDataSource>: DelegateHookBase<T>, UICollectionViewDelegate, UICollectionViewDataSource {
    var count: Int = 0
    weak var collectionView: UICollectionView! {
        didSet {
            hookCollectionViewAppear()
        }
    }

    fileprivate func hookCollectionViewAppear() {
        let wrappedBlock: @convention(block) (AspectInfo) -> Void = {
            [weak self] aspectInfo in
            SpeedLog.print(aspectInfo.instance())
            self?.collectionViewDidAppear()
        }
        let wrappedObject: AnyObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)

        do {
            _ = try collectionView.aspect_hook(#selector(UIView.didMoveToWindow), with: AspectOptions.positionBefore, usingBlock: wrappedObject)
        } catch {
            print(error)
        }
    }

    func collectionViewDidAppear() {
        SpeedLog.print()
        if collectionView.window != nil {
            scrollToIndex(1)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        count = nextHook.collectionView(collectionView, numberOfItemsInSection: section)
        self.collectionView = collectionView
        return count + 2
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataSourceIndex = mapToDatasourceIndexFrom(pageIndex: indexPath.row)
        return nextHook.collectionView(collectionView, cellForItemAt: IndexPath(row: dataSourceIndex, section: 0))
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dataSourceIndex = mapToDatasourceIndexFrom(pageIndex: indexPath.row)
        if let delegate = nextHook as? UICollectionViewDelegate{
            delegate.collectionView?(collectionView, didSelectItemAt: IndexPath(row: dataSourceIndex, section: 0))
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard count != 0 else {
            return
        }
        let currentPageIndex = scrollView.contentOffset.x / scrollView.frame.width
        if currentPageIndex == floor(currentPageIndex) {
            if currentPageIndex == 0 {
                scrollToIndex(count)
            } else if Int(currentPageIndex) == count + 1 {
                scrollToIndex(1)
            }
        }

        if let nextHook = self.nextHook as? UIScrollViewDelegate {
            nextHook.scrollViewDidScroll?(scrollView)
        }
    }

    func scrollToIndex(_ index: Int, animated: Bool = false) {
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    }

    func mapToDatasourceIndexFrom(pageIndex: Int) -> Int {
        var index = pageIndex
        switch index {
        case 0:
            index = count - 1
        case count + 1:
            index = 0
        default:
            index -= 1
        }
        return index
    }

    deinit {
        SpeedLog.print()
    }
}
