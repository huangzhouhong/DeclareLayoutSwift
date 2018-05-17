//
//  CollectionViewHostCell.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/21.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

class CollectionViewHostCell: UICollectionViewCell {
    public var element: UIElement?

    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let element = element else {
            return CGSize.zero
        }
        SpeedLog.print("input size:\(size)")
        element.setup()
        element.measure(DLSize(width: CGFloat.nan, height: CGFloat.nan))
        SpeedLog.print("element.desiredSize:\(element.desiredSize)")

        return element.desiredSize
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        guard let element = element else {
            return
        }
        SpeedLog.print(bounds)
        element.setup()
        element.arrange(bounds)
    }
}

extension UICollectionView {
    public func makeCell(element: UIElement, indexPath: IndexPath) -> UICollectionViewCell {
        // print("cellForItemAt:\(indexPath)")
        let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewHostCell
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        element.hostView = cell.contentView
        cell.element = element
        cell.setNeedsLayout() // layoutSubviews may not called if size not change

        return cell
    }
}
