//
//  CommunityTitleDelegate.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/23.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class CommunityTitleDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    let data = ["话题", "推荐", "动态"]
    let titleTintColor = UIColor("#2286F7")
    var titleController: CategoryTitleController?
    var currentIndex: Int {
        return titleController?.titleCurrentIndex ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = Label {
            $0.text = self.data[indexPath.row]
            $0.textColor = self.currentIndex == indexPath.row ? self.titleTintColor : .black
            $0.font = UIFont.systemFont(ofSize: 20)
        }

        return collectionView.makeCell(element: element, indexPath: indexPath)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        titleController?.scrollToItem(at: indexPath)
    }
}
