//
//  CommunityVC.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/20.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

enum CommunityPageType: Int {
    case topic, recommend, follow
    static var count: Int { return CommunityPageType.follow.rawValue + 1 }
}

class CommunityVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var titleDelegate: CommunityTitleDelegate!
    var titleController: CategoryTitleController!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleDelegate = CommunityTitleDelegate()
        var pageView: UICollectionView!
        var titleView: UICollectionView!

        navigationItem.titleView = HostView {
            Items(.height <- 44) { // set height, otherwise use desiredSize,which equal label height
                let collectionView = UICollectionViewFactory.createHStack(itemSpacing: 50)
                collectionView.dataSource = self.titleDelegate
                collectionView.backgroundColor = .clear
                titleView = collectionView
                return collectionView
            }
        }

        hostElement {
            Items {
                let collectionView = UICollectionViewFactory.createPage()
                collectionView.dataSource = self
                collectionView.delegate = self
                pageView = collectionView
                return collectionView
            }
        }

        titleController = CategoryTitleController(titleView: titleView, pageView: pageView)
        titleController.indicatorController.indicatorColor = titleDelegate.titleTintColor
        titleDelegate.titleController = titleController
    }

    // MARK: -

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return CommunityPageType.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageType = CommunityPageType(rawValue: indexPath.row)!
        var element: Table

        switch pageType {
        default:
            let topicDelegate = TopicDelegate()
            element = Table {
                $0.delegate = topicDelegate
                $0.dataSource = topicDelegate
            }

            topicDelegate.setupHeader(table: element)
            topicDelegate.retain(owner: element)
        }

        return collectionView.makeCell(element: element, indexPath: indexPath)
    }
}
