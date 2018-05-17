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
            let width = view.frame.width
            if width > 0 {
                createTableHeaderView(width: view.frame.width)
            }
        }
    }

    public convenience init(_ propertySetters: PropertySetter<Table>..., configViewBlock: (UITableView, Table) -> Void) {
        self.init()
        propertySetters.forEach { $0.setter(self) }
        configViewBlock(view, self)
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
            view.tableHeaderView = headerView
        }
    }

    override func arrangeOverwrite(rect: CGRect, innerRect: CGRect) {
        super.arrangeOverwrite(rect: rect, innerRect: innerRect)
        createTableHeaderView(width: rect.width)
    }
}
