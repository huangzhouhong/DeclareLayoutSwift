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
}
