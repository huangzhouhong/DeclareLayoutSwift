//
//  UICollectionViewFactory.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/5/7.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public class UICollectionViewFactory {
    public static func createHStack(itemSpacing: CGFloat = 0) -> UICollectionView {
        let layout = HStackLayout()
        layout.itemSpacing = itemSpacing
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }

    public static func createPage() -> UICollectionView {
        let layout = PageLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }

    public static func createUniform(columnCount: Int) -> UICollectionView {
        let layout = UniformLayout()
        layout.columnCount = columnCount
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }

    public static func createUniformPaging(eachPageColumnCount: Int, pageControl: UIPageControl? = nil) -> UICollectionView {
        let layout = UniformPagingLayout()
        layout.eachPageColumnCount = eachPageColumnCount
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true

        if let pageControl = pageControl {
            let pageCtrlController = PageCtrlController(collectionView: collectionView, pageControl: pageControl)
            pageCtrlController.retain(owner: collectionView)
        }

        return collectionView
    }
}
