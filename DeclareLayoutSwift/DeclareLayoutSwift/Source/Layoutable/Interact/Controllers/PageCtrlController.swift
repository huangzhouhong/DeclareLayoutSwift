//
//  PageCtrlController.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/5/7.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public class PageCtrlController: NSObject {
    weak var pageControl: UIPageControl?
    weak var collectionView: UICollectionView?
    var offsetObserver: KeyValueObserver!
    var conentSizeObserver: KeyValueObserver!

    public init(collectionView: UICollectionView, pageControl: UIPageControl) {
        self.collectionView = collectionView
        self.pageControl = pageControl
        super.init()

        offsetObserver = KeyValueObserver(object: collectionView, keyPath: "contentOffset", target: self, selector: #selector(onContentOffsetChanged), options: [.new, .initial])
        conentSizeObserver = KeyValueObserver(object: collectionView, keyPath: "contentSize", target: self, selector: #selector(onContentOffsetChanged), options: [.new, .initial])
    }

    @objc func onContentOffsetChanged() {
        guard let collectionView = collectionView, let pageControl = pageControl else {
            return
        }
        let pageCount = collectionView.contentSize.width / collectionView.frame.width
        let currentPageIndex = collectionView.contentOffset.x / collectionView.frame.width
        guard pageCount > 0 && currentPageIndex >= 0 else {
            return
        }

        pageControl.currentPage = Int(currentPageIndex)
        pageControl.numberOfPages = Int(pageCount)
    }
}
