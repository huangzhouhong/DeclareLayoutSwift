//
//  PagingElement.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/16.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import Foundation

@objc public protocol PagesDelegate {
//    func pages(_ pages: Pages, cellForItemAt index: Int) -> UIElement
//    @objc optional func pages(_ pages: Pages, didSelectItemAt index: Int)
    func pagesCellForItemAt(_ index: Int) -> UIElement
    func pageNumberOfItems() -> Int
    @objc optional func pagesDidSelectItemAt(_ index: Int)
}

public class Pages: Items, UICollectionViewDelegate, UICollectionViewDataSource {
    // `delegate` operator exist in `CollectionView`
    public weak var pagesDelegate: PagesDelegate?
    
    // >0 will enable auto scroll
    public var scrollDuration: TimeInterval = 0 {
        didSet {
            self.createTimer()
        }
    }
    
    public var loop: Bool = false
    
    private var timer: Timer?
    
    public init(_ propertySetters: PropertySetter<Pages>...,
                configViewBlock: ((UICollectionView) -> Void)? = nil) {
        super.init()
        propertySetters.forEach { $0.setter(self) }
        
        let layout = view.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.delegate = self
        view.dataSource = self
        
        configViewBlock?(view)
    }
    
    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        if let pagesDelegate = pagesDelegate {
            if pagesDelegate.pageNumberOfItems() > 0 {
                let element = pagesDelegate.pagesCellForItemAt(0)
                element.measure(DLSize(width: availableSize.width, height: CGFloat.nan))
                return element.desiredSize
            }
        }
        return CGSize.zero
    }
    
    func createTimer() {
        timer?.invalidate()
        if scrollDuration > 0 {
            timer = Timer.scheduledTimer(withTimeInterval: scrollDuration, repeats: true) { [weak self] _ in
                self?.onTimer()
            }
        }
    }
    
    func onTimer() {
        SpeedLog.print()
        if let delegate = pagesDelegate {
            let count = delegate.pageNumberOfItems()
            if count > 0 {
                let currentIndex = Int(view.contentOffset.x / view.frame.width)
                let newIndex = loop ? (currentIndex + 1) : (currentIndex + 1) % count
                scrollToIndex(newIndex, animated: true)
            }
        }
    }
    
    func mapToDatasourceIndexFrom(pageIndex: Int) -> Int {
        var index = pageIndex
        if loop {
            let count = pagesDelegate!.pageNumberOfItems()
            switch index {
            case 0:
                index = count - 1
            case count + 1:
                index = 0
            default:
                index -= 1
            }
        }
        return index
    }
    
    func scrollToIndex(_ index: Int, animated: Bool = false) {
        let indexPath = IndexPath(row: index, section: 0)
        view.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
//        SpeedLog.print("scrollToIndex:\(index)")
    }
    
    // MARK: - UIScrollViewDelegate
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard loop else {
            return
        }
        guard let pageCount = pagesDelegate?.pageNumberOfItems() else {
            return
        }
        let currentPageIndex = scrollView.contentOffset.x / view.frame.width
        if currentPageIndex == CGFloat(Int(currentPageIndex)) {
            if currentPageIndex == 0 {
                scrollToIndex(pageCount)
            } else if Int(currentPageIndex) == pageCount + 1 {
                scrollToIndex(1)
            }
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        createTimer()
    }
    
    // MARK: - collectionView
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let num = pagesDelegate?.pageNumberOfItems() {
            if num > 0 {
                return loop ? num + 2 : num
            }
        }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = mapToDatasourceIndexFrom(pageIndex: indexPath.row)
        
        // explicit size here
        // Because we don't need the framework to automatically calculate for us
        let element = pagesDelegate!.pagesCellForItemAt(index)
        element.width = collectionView.frame.width
        element.height = collectionView.frame.height
        
        return collectionView.makeCell(element: element, indexPath: indexPath)
    }
    
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return collectionView.sizeForItem(indexPath)
//    }
}
