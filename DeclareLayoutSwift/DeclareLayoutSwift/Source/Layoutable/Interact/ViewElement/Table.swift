//
//  Table.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/31.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

public class Table: ViewElement<UITableView> {
    public var header: UIElement? {
        didSet {
            let width = self.view.frame.width
            if width > 0 {
                self.createTableHeaderView(width: self.view.frame.width)
            }
        }
    }

    func createTableHeaderView(width: CGFloat) {
        if let header = header {
            let headerView = UIView()
            headerView.translatesAutoresizingMaskIntoConstraints = false
            header.setup()
            header.measure(DLSize(width: width, height: CGFloat.nan))
            header.hostView = headerView
            let rect = CGRect(x: 0, y: 0, width: width, height: header.desiredSize.height)
            headerView.frame = rect
            header.arrange(rect)
            self.view.tableHeaderView = headerView
        }
    }

    override func arrangeOverwrite(rect: CGRect, innerRect: CGRect) {
        super.arrangeOverwrite(rect: rect, innerRect: innerRect)
        self.createTableHeaderView(width: rect.width)
    }

//    public init(_ propertySetters: PropertySetter<ViewElement<UITableView>>...) {
//        super.init(view:UITableView())
//        propertySetters.forEach { $0.setter(self) }
//    }
}
