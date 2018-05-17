//
//  ViewController.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/7.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var titleDelegate: HomeTitleDelegate!
    var titleController: CategoryTitleController!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleDelegate = HomeTitleDelegate()
        var pagesView: UICollectionView!
        var titleView: UICollectionView!

        navigationItem.titleView = HostView {
            Items {
                $0.delegate = self.titleDelegate
                $0.dataSource = self.titleDelegate
                $0.backgroundColor = .clear
                $0.showsHorizontalScrollIndicator = false

                let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout
                layout?.scrollDirection = .horizontal
                titleView = $0
            }
        }

        hostElement {
            Items {
                let collectionView = UICollectionViewFactory.createPage()
                collectionView.delegate = self
                collectionView.dataSource = self
                pagesView = collectionView
                return collectionView
            }
        }

        titleController = CategoryTitleController(titleView: titleView, pageView: pagesView)
        titleDelegate.titleController = titleController
    }

    // MARK: -

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return titleDelegate.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tableDelegate = HomePageDelegate()
        let element = Table { $0.dataSource = tableDelegate }

        tableDelegate.retain(owner: element)
        return collectionView.makeCell(element: element, indexPath: indexPath)
    }
}
