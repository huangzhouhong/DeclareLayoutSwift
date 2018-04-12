//
//  LinearGrid.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/11.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

/*
 auto set column/row index for children
 */
public class LinearGrid: Grid {
    public init(_ propertySetters: PropertySetter<LinearGrid>...) {
        super.init()
        propertySetters.forEach { $0.setter(self) }
    }

    public override func setup() {
        let errorMsg = "not support, use Grid instead"
        let noRows = rows == nil || rows.count < 2
        let noColumns = columns == nil || columns.count < 2

        precondition(noRows || noColumns, "\(errorMsg): must use one of rows or columns")

        if !noRows {
            precondition(rows.count == children.count, "\(errorMsg): rows.count must equal children count")
            for (index, child) in children.enumerated() {
                Grid.setRow(ele: child, row: index)
            }
        } else if !noColumns {
            precondition(columns.count == children.count, "\(errorMsg): columns.count must equal children count")
            for (index, child) in children.enumerated() {
                Grid.setColumn(ele: child, column: index)
            }
        }

        super.setup()
    }
}
