//
//  CollectionView.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/4.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public class Items: ViewElement<UICollectionView> {
    public init(_ propertySetters: [PropertySetter<Items>]) {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewHostCell.self, forCellWithReuseIdentifier: "cell")

        super.init(view: collectionView)

        propertySetters.forEach { $0.setter(self) }
    }

    public init(_ propertySetters: PropertySetter<Items>..., createViewBlock: () -> UICollectionView) {
        let collectionView = createViewBlock()
        collectionView.register(CollectionViewHostCell.self, forCellWithReuseIdentifier: "cell")
        super.init(view: collectionView)
        propertySetters.forEach { $0.setter(self) }
    }

    public convenience init(_ propertySetters: PropertySetter<Items>...,
                            configViewBlock: ((UICollectionView) -> Void)? = nil) {
        self.init(propertySetters)
        configViewBlock?(view)
    }

//    public convenience init(_ propertySetters: PropertySetter<Items>...,
//                            configViewBlock: (UICollectionView, Items) -> Void) {
//        self.init(propertySetters)
//        configViewBlock(view, self)
//    }

    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        // CGFloat.greatestFiniteMagnitude will cause `layoutIfNeeded` not return
        let maxSpace: CGFloat = 1000
        SpeedLog.print("start with size:\(availableSize)")

        if let layout = self.view.collectionViewLayout as? UICollectionViewFlowLayout {
            if layout.scrollDirection == .vertical && availableSize.width > 0 {
                view.frame = CGRect(x: 0, y: 0, width: availableSize.width, height: maxSpace)
                view.layoutIfNeeded()
                return view.contentSize
            } else if layout.scrollDirection == .horizontal && availableSize.height > 0 {
                view.frame = CGRect(x: 0, y: 0, width: maxSpace, height: availableSize.height)
                view.layoutIfNeeded()
                return view.contentSize
            }
        } else if let _ = view.collectionViewLayout as? HStackLayout {
            SpeedLog.print("before layout content size:\(view.contentSize)")
            let width = availableSize.width > 0 ? availableSize.width : maxSpace
            view.frame = CGRect(x: 0, y: 0, width: width, height: maxSpace)
            view.layoutIfNeeded()
            SpeedLog.print("after layout content size:\(view.contentSize)")

            var desiredSize = view.contentSize
            desiredSize.addInset(inset: view.contentInset)
            return desiredSize
        } else if let layout = view.collectionViewLayout as? SelfSizingLayoutBase {
            layout.measure = true
            layout.availableSize = availableSize

            SpeedLog.print("before layout content size:\(view.contentSize)")
            view.frame = CGRect(x: 0, y: 0, width: maxSpace, height: maxSpace) // big size force all cell calculate
            view.layoutIfNeeded()
            SpeedLog.print("after layout content size:\(view.contentSize)")

            var desiredSize = view.contentSize
            desiredSize.addInset(inset: view.contentInset)

            layout.measure = false
            return desiredSize
        }
        return super.measureOverwrite(availableSize)
    }
}
