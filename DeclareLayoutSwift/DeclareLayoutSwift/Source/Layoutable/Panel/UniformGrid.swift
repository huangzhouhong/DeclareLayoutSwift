//
//  UniformGrid.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/31.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

public class UniformGrid: Panel {
    var columnCount:Int
    init(columnCount:Int) {
        self.columnCount = columnCount
        super.init()
    }
    
    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        SpeedLog.print("availableSize:\(availableSize)")
        var result = CGSize.zero
        if let firstChild = children.first{
            firstChild.measure(DLSize.nan)
            let rowCount = ceil(CGFloat(children.count) / CGFloat(columnCount))
            result = CGSize(width:firstChild.desiredSize.width * CGFloat(columnCount),
                          height:firstChild.desiredSize.height * rowCount)
        }
        SpeedLog.print("result:\(result)")
        return result
    }
    
    override func arrangeOverwrite(rect: CGRect, innerRect: CGRect) {
        if children.count != 0 {
            let rowCount = Int(ceil(CGFloat(children.count) / CGFloat(columnCount)))
            let cellWidth = innerRect.width / CGFloat(columnCount)
            let cellHeight = innerRect.height / CGFloat( rowCount)
            let minX = innerRect.minX
            let minY = innerRect.minY
            
            for (index,child) in children.enumerated(){
                let columnIndex = index % columnCount
                let rowIndex = Int(floor(CGFloat(index) / CGFloat(columnCount)))
                let x = minX + cellWidth * CGFloat(columnIndex)
                let y = minY + cellHeight * CGFloat(rowIndex)
                child.arrange(CGRect(x: x, y: y, width: cellWidth, height: cellHeight))
            }
        }
    }
}
