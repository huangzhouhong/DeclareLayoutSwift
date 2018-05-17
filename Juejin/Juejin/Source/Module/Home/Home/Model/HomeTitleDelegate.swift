//
//  HomeTitleDelegate.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/9.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class HomeTitleDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    let data = ["首页", "Android", "iOS", "工具资源", "产品", "设计", "后端"]
    var titleController: CategoryTitleController?
    var currentIndex:Int{
       return titleController?.titleCurrentIndex ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = Label(.margin <- Insets(vertical: 0, horizontal: 10)) {
            $0.text = self.data[indexPath.row]
            $0.textColor = self.currentIndex == indexPath.row ? .red : .gray
        }

        return collectionView.makeCell(element: element, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        titleController?.scrollToItem(at: indexPath)
    }
}
