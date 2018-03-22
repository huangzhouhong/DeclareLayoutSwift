//
//  CollectionCellHost.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/21.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

extension UICollectionViewCell: SupportStoreProperty {
    struct PropertyNames {
        static var element = "element"
    }
    
    public var element: UIElement? {
        set {
            setValue(key: &PropertyNames.element, value: newValue)
        }
        get {
            return getValue(key: &PropertyNames.element) as? UIElement
        }
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let element = element else {
            return CGSize.zero
        }
        element.setup()
        element.measure(DLSize(width: CGFloat.nan, height: CGFloat.nan))
        
        element.hostView = contentView
        element.arrange(CGRect(x: 0, y: 0, width: element.desiredSize.width, height: element.desiredSize.height))
        return element.desiredSize
    }
}

extension UICollectionView: SupportStoreProperty {
    public func makeCell(element: UIElement, indexPath: IndexPath) -> UICollectionViewCell {
        //        print("cellForItemAt:\(indexPath)")
        let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.element = element
        
        return cell
    }
}
