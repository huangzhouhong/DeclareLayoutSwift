//
//  CollectionView.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/4.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

class UICollectionViewStore: NSObject {
    var sizeForItems: Dictionary<IndexPath, CGSize> = [:]
}

extension UICollectionView: SupportStoreProperty {
    struct PropertyNames {
        static var store = "store"
    }
    
    var store: UICollectionViewStore {
        if let s = getValue(key: &PropertyNames.store) as? UICollectionViewStore {
            return s
        } else {
            let s = UICollectionViewStore()
            setValue(key: &PropertyNames.store, value: s)
            return s
        }
    }
    
    public func makeCell(element: UIElement, indexPath: IndexPath) -> UICollectionViewCell {
//        print("cellForItemAt:\(indexPath)")
        let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let contentView = cell.contentView
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
//        let element = StackPanel {
//            ImageView(.image <- "osx") &
//                Label(.text <- "work")
//        }
        element.setup()
        element.measure(DLSize(width: CGFloat.nan, height: CGFloat.nan))
        
        element.hostView = contentView
        element.arrange(CGRect(x: 0, y: 0, width: element.desiredSize.width, height: element.desiredSize.height))
        
        var needReload = true
        if let oldSize = store.sizeForItems[indexPath] {
            if oldSize.equalTo(element.desiredSize) {
                needReload = false
            }
        }
        if needReload {
            store.sizeForItems[indexPath] = element.desiredSize
            collectionViewLayout.invalidateLayout()
        }
        
        return cell
    }
    
    public func sizeForItem(_ indexPath: IndexPath) -> CGSize {
        return store.sizeForItems[indexPath] ?? CGSize(width: 50, height: 50)
    }
}

public class Items: ViewElement<UICollectionView> {
    
    public init(_ propertySetters: PropertySetter<Items>...,
                configViewBlock: ((UICollectionView) -> Void)? = nil) {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        super.init(view: collectionView)
        
        propertySetters.forEach { $0.setter(self) }
        configViewBlock?(view)
    }
}
