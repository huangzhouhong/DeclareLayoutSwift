//
//  DelegateHookBase.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/5/9.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import Aspects
import Foundation

open class DelegateHookBase<T:NSObject>: NSObject {
    weak var nextHook: T!
    
    public init(weakHook:T) {
        self.nextHook = weakHook
    }
    
    public init(strongHook:T) {
        self.nextHook = strongHook
        super.init()
        strongHook.retain(owner: self)
    }
    
    open override func responds(to aSelector: Selector!) -> Bool {
        SpeedLog.print(aSelector)
        if super.responds(to: aSelector) {
            return true
        } else {
            return nextHook.responds(to: aSelector) 
        }
    }

    open override func forwardingTarget(for _: Selector!) -> Any? {
        return nextHook
    }
}

//public class UICollectionViewInfiniteLoopHook: NSObject,UIScrollViewDelegate {
//    weak var delegate: AnyObject!
//    var count: Int = 0
//    weak var collectionView: UICollectionView! {
//        didSet {
//            hookCollectionViewAppear()
//        }
//    }
//
//    public static func install<T: NSObject & UICollectionViewDataSource>(delegate: T) {
//        let hook = UICollectionViewInfiniteLoopHook(delegate: delegate)
//        hook.retain(owner: delegate)
//    }
//
//    public init<T: NSObject & UICollectionViewDataSource>(delegate: T) {
//        self.delegate = delegate
//        super.init()
//
//        hookNumberOfItemsInSection()
//        hookCellCreate()
//    }
//
//    // MARK: - hook UICollectionView Appear
//
//    fileprivate func hookCollectionViewAppear() {
//        let wrappedBlock: @convention(block) (AspectInfo) -> Void = {
//            [weak self] aspectInfo in
//            SpeedLog.print(aspectInfo.instance())
//            self?.collectionViewDidAppear()
//        }
//        let wrappedObject: AnyObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
//
//        do {
//            _ = try collectionView.aspect_hook(#selector(UIView.didMoveToWindow), with: AspectOptions.positionBefore, usingBlock: wrappedObject)
//        } catch {
//            print(error)
//        }
//    }
//
//    func collectionViewDidAppear() {
//        SpeedLog.print()
//        if collectionView.window != nil {
//            scrollToIndex(1)
//        }
//    }
//
//    // MARK: - hook Datasource
//
//    // change return value
//    func hookNumberOfItemsInSection() {
//        let wrappedBlock: @convention(block) (AspectInfo) -> Void = {
//            [weak self] aspectInfo in
//            let invocation = aspectInfo.originalInvocation()!
//            invocation.invoke()
//
//            var returnValue: Int = 0
//            invocation.getReturnValue(&returnValue)
//            self?.count = returnValue
//            returnValue += 2
//            invocation.setReturnValue(&returnValue)
//
//            var collectionView: UICollectionView!
//            invocation.getArgument(&collectionView, at: 2)
//            self?.collectionView = collectionView
//        }
//        let wrappedObject: AnyObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
//
//        do {
//            _ = try delegate.aspect_hook(#selector(UICollectionViewDataSource.collectionView(_:numberOfItemsInSection:)), with: AspectOptions.positionInstead, usingBlock: wrappedObject)
//        } catch {
//            print(error)
//        }
//    }
//
//    // modify input argument `indexPath`
//    func hookCellCreate() {
//        let wrappedBlock: @convention(block) (AspectInfo) -> Void = {
//            [weak self] aspectInfo in
//
//            guard let strongSelf = self else {
//                return
//            }
//
//            let invocation = aspectInfo.originalInvocation()!
//
//            /*
//             if use `invocation.getArgument(&indexPath, at: 3)`
//             ARC will release IndexPath when it out of scope (cause EXC_BAD_ACCESS)
//             see: https://stackoverflow.com/questions/22018272/nsinvocation-returns-value-but-makes-app-crash-with-exc-bad-access?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
//             */
//            var indexPathAddress: Int = 0
//            invocation.getArgument(&indexPathAddress, at: 3)
//            let indexPath = unsafeBitCast(indexPathAddress, to: NSIndexPath.self)
//
//            let dataSourceIndex = strongSelf.mapToDatasourceIndexFrom(pageIndex: indexPath.row)
//            var dataSourceIndexPath = NSIndexPath(row: dataSourceIndex, section: 0)
//            invocation.setArgument(&dataSourceIndexPath, at: 3)
//
//            invocation.invoke()
//        }
//        let wrappedObject: AnyObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
//
//        do {
//            _ = try delegate.aspect_hook(#selector(UICollectionViewDataSource.collectionView(_:cellForItemAt:)), with: AspectOptions.positionInstead, usingBlock: wrappedObject)
//        } catch {
//            print(error)
//        }
//    }
//
//    // MARK: - UIScrollViewDelegate
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard count != 0 else {
//            return
//        }
//        let currentPageIndex = scrollView.contentOffset.x / scrollView.frame.width
//        if currentPageIndex == floor(currentPageIndex) {
//            if currentPageIndex == 0 {
//                scrollToIndex(count)
//            } else if Int(currentPageIndex) == count + 1 {
//                scrollToIndex(1)
//            }
//        }
//
////        if let nextHook = self.nextHook as? UIScrollViewDelegate {
////            nextHook.scrollViewDidScroll?(scrollView)
////        }
//    }
//
//    // MARK: - Common
//
//    func scrollToIndex(_ index: Int, animated: Bool = false) {
//        let indexPath = IndexPath(row: index, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
//    }
//
//    func mapToDatasourceIndexFrom(pageIndex: Int) -> Int {
//        var index = pageIndex
//        switch index {
//        case 0:
//            index = count - 1
//        case count + 1:
//            index = 0
//        default:
//            index -= 1
//        }
//        return index
//    }
//}

