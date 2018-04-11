//
//  CategoryDelegate.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/9.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class CategoryDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    let data = ["首页", "Android", "iOS", "工具资源", "产品", "设计", "后端"]
    var categorySelected: ((Int) -> Void)?
    weak var collectionView: UICollectionView!
    var indicatorView: UIView!
    var currentIndex: Int = 0 {
        didSet {
            if oldValue != currentIndex {
                collectionView.reloadData()
                collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionView = collectionView
        if self.indicatorView == nil {
            self.indicatorView = UIView()
            self.indicatorView.backgroundColor = .red
            collectionView.addSubview(self.indicatorView)
        }
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let textColor = self.currentIndex == indexPath.row ? UIColor.red : UIColor.gray
        let element = Label(.text <- data[indexPath.row], .margin <- Insets(vertical: 0, horizontal: 10), .textColor <- textColor)
        
        return collectionView.makeCell(element: element, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.pagesScroll(to: CGFloat(indexPath.row))
        self.categorySelected?(indexPath.row)
    }
    
    func pagesScroll(to currentPageIndex: CGFloat) {
        let leftItemIndex = floor(currentPageIndex)
        let rightItemIndex = ceil(currentPageIndex)
        
//        SpeedLog.print("leftItemIndex:\(leftItemIndex),rightItemIndex:\(rightItemIndex)")
        let leftCell = collectionView.cellForItem(at: IndexPath(row: Int(leftItemIndex), section: 0))
        let rightCell = collectionView.cellForItem(at: IndexPath(row: Int(rightItemIndex), section: 0))
//        SpeedLog.print("leftCell:\(leftCell),rightCell:\(rightCell)")
        
        if let leftCell = leftCell, let rightCell = rightCell {
            let leftRect = leftCell.convert(leftCell.bounds, to: collectionView)
            let rightRect = rightCell.convert(rightCell.bounds, to: collectionView)
            
            let x = leftRect.minX + (rightRect.minX - leftRect.minX) * (currentPageIndex - leftItemIndex)
            let height: CGFloat = 4
            let y: CGFloat = collectionView.frame.height - height
            let rightPercent = currentPageIndex - leftItemIndex
            let width: CGFloat = leftRect.width * (1 - rightPercent) + rightRect.width * rightPercent
            indicatorView.frame = CGRect(x: x, y: y, width: width, height: height)
            SpeedLog.print(x)
        }
        
        self.currentIndex = Int(floor(currentPageIndex + 0.5))
    }
}
