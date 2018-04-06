//
//  CollectionView.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/4.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public class Items: ViewElement<UICollectionView> {
    public init(_ propertySetters: PropertySetter<Items>...,
                configViewBlock: ((UICollectionView) -> Void)? = nil) {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        super.init(view: collectionView)

        propertySetters.forEach { $0.setter(self) }
        configViewBlock?(view)
    }

    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        // CGFloat.greatestFiniteMagnitude will cause `layoutIfNeeded` not return
        let maxSpace: CGFloat = 1000

        if let layout = self.view.collectionViewLayout as? UICollectionViewFlowLayout {
            if layout.scrollDirection == .vertical && availableSize.width > 0 {
                self.view.frame = CGRect(x: 0, y: 0, width: availableSize.width, height: maxSpace)
                self.view.layoutIfNeeded()
                return self.view.contentSize
            } else if layout.scrollDirection == .horizontal {
                self.view.frame = CGRect(x: 0, y: 0, width: maxSpace, height: maxSpace)
                self.view.layoutIfNeeded()
                return self.view.contentSize
//                if let firstElement = firstElement {
//                    firstElement.measure(DLSize(width: availableSize.width, height: CGFloat.nan))
//                    return CGSize(width: availableSize.width, height: firstElement.desiredSize.height)
//                }
            }
        }
        return super.measureOverwrite(availableSize)
    }

//    var firstElement: UIElement? {
//        if let dataSource = view.dataSource {
//            if let numberOfSections = dataSource.numberOfSections?(in: view) {
//                if numberOfSections > 0 {
//                    return self.getFirstElement(dataSource: dataSource)
//                }
//            } else {
//                return self.getFirstElement(dataSource: dataSource)
//            }
//        }
//        return nil
//    }
//
//    private func getFirstElement(dataSource: UICollectionViewDataSource) -> UIElement? {
//        if dataSource.collectionView(view, numberOfItemsInSection: 0) > 0 {
//            let firstCell = dataSource.collectionView(view, cellForItemAt: IndexPath(row: 0, section: 0))
//            return firstCell.element
//        }
//        return nil
//    }
}
