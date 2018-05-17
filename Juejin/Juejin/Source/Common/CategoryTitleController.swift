//
//  CategoryTitleController.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/5/7.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

class CategoryTitleController: NSObject {
    weak var titleView: UICollectionView?
    weak var pageView: UICollectionView?
    var indicatorController: ItemsIndicatorContoller!
    var titleCurrentIndex: Int = 0 {
        didSet {
            guard let titleView = titleView else {
                return
            }
            if oldValue != titleCurrentIndex {
                titleView.reloadData()
                titleView.scrollToItem(at: IndexPath(row: titleCurrentIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }

    init(titleView: UICollectionView, pageView: UICollectionView) {
        self.titleView = titleView
        self.pageView = pageView
        super.init()

        indicatorController = ItemsIndicatorContoller(collectionView: titleView)
        pageView.addObserver(self, forKeyPath: "contentOffset", options: [.new, .initial], context: nil)
        pageView.addObserver(self, forKeyPath: "contentSize", options: [.new, .initial], context: nil)
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change _: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        if object as? UICollectionView == pageView {
            scrollTitle()
        }
    }

    func scrollTitle() {
        guard let pageView = pageView else {
            return
        }
        let currentPageIndex = pageView.contentOffset.x / pageView.frame.width
        guard currentPageIndex >= 0 else{
            return
        }
        indicatorController.setCurrentItemIndex(currentPageIndex)
        titleCurrentIndex = Int(floor(currentPageIndex + 0.5))
    }

    func scrollToItem(at indexPath: IndexPath){
        pageView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    deinit {
        pageView?.removeObserver(self, forKeyPath: "contentOffset")
        pageView?.removeObserver(self, forKeyPath: "contentSize")
    }
}
