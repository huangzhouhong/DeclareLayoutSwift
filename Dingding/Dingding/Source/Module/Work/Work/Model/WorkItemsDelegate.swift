//
//  WorkItemsDelegate.swift
//  Dingding
//
//  Created by 黄周鸿 on 2018/4/29.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit
import DeclareLayoutSwift

enum WorkCellType: Int {
    case app, otherApp
    static var count: Int { return WorkCellType.otherApp.rawValue + 1 }
}

typealias WorkIcon = (image: String, name: String)

class WorkItemsDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var model: [WorkIcon]
    init(model: [WorkIcon]) {
        self.model = model
    }
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = model[indexPath.row]
        let element = StackPanel(.margin <- Insets(5))[
            Image(.hAlign <- .Center) {
                $0.image = UIImage(named: data.image)
            },
            Label(.hAlign <- .Center, .margin <- Insets(top: 4)) {
                $0.text = data.name
                $0.font = UIFont.systemFont(ofSize: 14)
            }
        ]
        
        return collectionView.makeCell(element: element, indexPath: indexPath)
    }
}

