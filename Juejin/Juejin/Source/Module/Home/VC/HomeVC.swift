//
//  ViewController.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/7.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class HomeVC: UIViewController, PagesDelegate {
    var categoryDelegate: CategoryDelegate!
    var pages: Pages!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryDelegate = CategoryDelegate()
        self.categoryDelegate.categorySelected = {
            [weak self] newIndex in
            self?.pages.view.scrollToItem(at: IndexPath(row: newIndex, section: 0), at: .centeredHorizontally, animated: true)
        }

        let titleView = HostView {
            Items(.delegate <- categoryDelegate, .dataSource <- categoryDelegate, .bgColor <- UIColor.clear) {
                collectionView in
                collectionView.showsHorizontalScrollIndicator = false
                let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                layout?.scrollDirection = .horizontal
            }
        }

        self.navigationItem.titleView = titleView

        self.hostElement {
            Pages(.pagesDelegate <- self, .bgColor <- UIColor.white).outlet(&pages)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        self.categoryDelegate.pagesScroll(to: 0)
    }

    // MARK: - PagesDelegate

    func pagesCellForItemAt(_ index: Int) -> UIElement {
        let tableDelegate = HomePageDelegate()
        let element = Table(.dataSource <- tableDelegate)
        tableDelegate.retain(owner: element)
        return element
    }

    func pageNumberOfItems() -> Int {
        return self.categoryDelegate.data.count
    }

    func pagesDidScroll(offset: CGFloat) {
        let currentPageIndex = offset / pages.view.frame.width
        categoryDelegate.pagesScroll(to: currentPageIndex)
    }
}
