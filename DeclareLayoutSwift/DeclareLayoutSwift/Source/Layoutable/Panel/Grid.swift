//
//  Grid.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/12.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

@objcMembers
public class Grid: Panel {
    public enum Definition {
        case Fixed(size: CGFloat)
        case Star(star: CGFloat, min: CGFloat?, max: CGFloat?) // star,min,max
        case Auto(min: CGFloat?, max: CGFloat?) // min,max

        // for convenience
        public static var auto: Definition {
            return .Auto(min: nil, max: nil)
        }

        public static func auto(min: CGFloat? = nil, max: CGFloat? = nil) -> Definition {
            return .Auto(min: min, max: max)
        }

        public static func fixed(_ size: CGFloat) -> Definition {
            return .Fixed(size: size)
        }

        public static func star(_ star: CGFloat, min: CGFloat? = nil, max: CGFloat? = nil) -> Definition {
            return .Star(star: star, min: min, max: max)
        }
    }

    var rows: [Definition]!
    var columns: [Definition]!

    public init(_ propertySetters: PropertySetter<Grid>...) {
        super.init()
        propertySetters.forEach { $0.setter(self) }
    }

    private var childrenForColumns: [[Layoutable]]!
    private var childrenForRows: [[Layoutable]]!

    struct PropertyNames {
        static var column = "column"
        static var row = "row"
    }

    static func setColumn(ele: Layoutable, column: Int) {
        ele.setValue(key: &PropertyNames.column, value: column)
    }

    static func getColumn(ele: Layoutable) -> Int {
        let c = ele.getValue(key: &PropertyNames.column) as? Int
        return c ?? 0
    }

    static func setRow(ele: Layoutable, row: Int) {
        ele.setValue(key: &PropertyNames.row, value: row)
    }

    static func getRow(ele: Layoutable) -> Int {
        let c = ele.getValue(key: &PropertyNames.row) as? Int
        return c ?? 0
    }

    public override func setup() {
        super.setup()

        if rows == nil || rows.count == 0 {
            rows = [.Star(star: 1, min: nil, max: nil)]
        }

        if columns == nil || columns.count == 0 {
            columns = [.Star(star: 1, min: nil, max: nil)]
        }

        // save element in row(column)
        childrenForColumns = [[Layoutable]](repeating: [], count: columns.count)
        childrenForRows = [[Layoutable]](repeating: [], count: rows.count)
        for ele in children {
            var rowIndex = Grid.getRow(ele: ele)
            var columnIndex = Grid.getColumn(ele: ele)
            if rowIndex >= childrenForRows.count {
                SpeedLog.print("\(ele) grid row out of index")
                rowIndex = 0
                Grid.setRow(ele: ele, row: rowIndex)
            }
            if columnIndex >= childrenForColumns.count {
                SpeedLog.print("\(ele) grid column out of index")
                columnIndex = 0
                Grid.setColumn(ele: ele, column: columnIndex)
            }
            childrenForRows[rowIndex].append(ele)
            childrenForColumns[columnIndex].append(ele)
        }
    }

    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        SpeedLog.print("start measture,availableSize:\(availableSize)")

        let convertToAutoDefs: ([Definition]) -> [Definition] = {
            $0.map {
                def in
                if case let .Star(_, minSpace, maxSpace) = def {
                    return .Auto(min: minSpace, max: maxSpace)
                } else {
                    return def
                }
            }
        }

        let measureRows: [Definition] = availableSize.height.isNaN ? convertToAutoDefs(rows) : rows
        let measureColumns: [Definition] =
            availableSize.width.isNaN ? convertToAutoDefs(columns) : columns

        let (rowHeights, columnWidths) = satisfyDefinitions(width: availableSize.width, height: availableSize.height, rowDefs: measureRows, columnDefs: measureColumns)

        return CGSize(width: columnWidths.reduce(0, +), height: rowHeights.reduce(0, +))
    }

    override func arrangeOverwrite(rect: CGRect, innerRect: CGRect) {
        SpeedLog.print("start arrage with rect:\(rect),innerRect\(innerRect)")

        let cellRects = getCellRects(innerRect)
        for child in children {
            let rowIndex = Grid.getRow(ele: child)
            let columnIndex = Grid.getColumn(ele: child)
//            if rowIndex >= rows.count {
//                rowIndex = 0
//                SpeedLog.print("\(child) grid row out of index")
//            }
//            if columnIndex >= columns.count {
//                columnIndex = 0
//                SpeedLog.print("\(child) grid column out of index")
//            }

            let cellRect = cellRects[rowIndex][columnIndex]
            arrange(child: child, cellRect: cellRect)
        }
    }

    func arrange(child: Layoutable, cellRect: CGRect) {
        let childVerticalAlign = child.verticalAlignment ?? .Stretch
        let childHorizontalAlign = child.horizontalAlignment ?? .Stretch
//        var childWidth = child.width ?? child.desiredSize.width
//        var childHeight = child.height ?? child.desiredSize.height

        // child can arrange without measure (.Stretch)
        // make these variable lazy
//        var calcChildWidth = { () -> CGFloat in
//            if let childWidth = child.width{
//                return childWidth
//            }else{
//                if !self.measuredChildren.contains(child as! NSObject) {
//                    self.measure(child: child, availableWidth: cellRect.width, availableHeight: cellRect.height)
//                }
//                return child.desiredSize.width
//            }
        ////            child.width ?? child.desiredSize.width
        //
//        }
//        var calcChildHeight = {child.height ?? child.desiredSize.height}

        var x = cellRect.minX
        var y = cellRect.minY
        let cellWidth = cellRect.width
        let cellHeight = cellRect.height

        var childWidth: CGFloat = cellWidth // if .Stretch
        var childHeight: CGFloat = cellHeight
        if childHorizontalAlign != .Stretch {
//            if let explicitWidth = child.width {
//                childWidth = explicitWidth
//            } else {
            if !child.measured {
                child.measure(DLSize(width: cellWidth, height: cellHeight))
            }
            childWidth = child.desiredSize.width
//            }
        }
        if childVerticalAlign != .Stretch {
//            if let explicitHeight = child.height {
//                childHeight = explicitHeight
//            } else {
            if !child.measured {
                child.measure(DLSize(width: cellWidth, height: cellHeight))
            }
            childHeight = child.desiredSize.height
//            }
        }

        switch childHorizontalAlign {
        case .Right:
            x += cellWidth - childWidth
        case .Center:
            x += (cellWidth - childWidth) / 2
        default: break
        }

        switch childVerticalAlign {
        case .Bottom:
            y += cellHeight - childHeight
        case .Center:
            y += (cellHeight - childHeight) / 2
        default: break
        }

        child.arrange(CGRect(x: x, y: y, width: childWidth, height: childHeight))
    }

//    func measure(child: Layoutable, availableWidth: CGFloat, availableHeight: CGFloat) {
//        measuredChildren.insert(child as! NSObject)
//        child.measure(DLSize(width: availableWidth, height: availableHeight))
//    }

    func getCellRects(_ finalRect: CGRect) -> [[CGRect]] {
        let (rowHeights, columnWidths) = satisfyDefinitions(width: finalRect.width, height: finalRect.height, rowDefs: rows, columnDefs: columns)

        var cellRects = [[CGRect]](repeating: [CGRect](repeating: CGRect.zero, count: columnWidths.count), count: rowHeights.count)

        var x = finalRect.minX
        for (colIndex, columnWidth) in columnWidths.enumerated() {
            var y = finalRect.minY
            for (rowIndex, rowHeight) in rowHeights.enumerated() {
                cellRects[rowIndex][colIndex] = CGRect(x: x, y: y, width: columnWidth, height: rowHeight)
                y += rowHeight
            }
            x += columnWidth
        }
        SpeedLog.print("cellRects:\(cellRects)")
        return cellRects
    }

    func satisfyDefinitions(width: CGFloat, height: CGFloat, rowDefs: [Definition], columnDefs: [Definition]) -> (rowHeights: [CGFloat], columnWidths: [CGFloat]) {
        let columnWidths =
            satisfy(availabelSpace: width, defs: columnDefs, childrenForDefIndex: { childrenForColumns[$0] }, measureChild: { child, space in
//                if let explicitWidth = child.width{
//                    return explicitWidth
//                }else{
                child.measure(DLSize(width: space, height: CGFloat.nan))
                return child.desiredSize.width
//                }
            })

        let rowHeights =
            satisfy(availabelSpace: height, defs: rowDefs, childrenForDefIndex: { childrenForRows[$0] }, measureChild: { child, space in
//                if let explicitHeight = child.height{
//                    return explicitHeight
//                }else{
                let columnIndex = Grid.getColumn(ele: child)
                child.measure(DLSize(width: columnWidths[columnIndex], height: space))
                return child.desiredSize.height
//                }
            })

        return (rowHeights, columnWidths)
    }

    func satisfy(availabelSpace: CGFloat, defs: [Definition], childrenForDefIndex: (Int) -> [Layoutable], measureChild: (Layoutable, CGFloat) -> CGFloat) -> [CGFloat] {
        var starDefinitions: [(index: Int, def: Definition)] = []
        var totalStar: CGFloat = 0
        var splitResult: [CGFloat] = [CGFloat](repeating: 0, count: defs.count)
        let calcRemainSpace = {
            availabelSpace - splitResult.reduce(0, +)
        }

        for (index, def) in defs.enumerated() {
            switch def {
            case let .Fixed(space):
                splitResult[index] = space
            case let .Auto(minSpace, maxSpace):
//                let remainSpace = calcRemainSpace()
                let maxDesiredSpace =
                    childrenForDefIndex(index).map({ child -> CGFloat in
//                        var desiredSpace = measureChild(child, remainSpace)
                        var desiredSpace = measureChild(child, CGFloat.nan)
                        if let minSpace = minSpace {
                            desiredSpace = max(minSpace, desiredSpace)
                        }
                        if let maxSpace = maxSpace {
                            desiredSpace = min(maxSpace, desiredSpace)
                        }
                        return desiredSpace
                    }).max()
                splitResult[index] = maxDesiredSpace ?? 0
            case let .Star(star, _, _):
                starDefinitions.append((index, def))
                totalStar += star
            }
        }

        var remainSpace = calcRemainSpace()

        if remainSpace < 0 || totalStar == 0 {
            return splitResult
        }

        if availabelSpace.isNaN {
            fatalError("must not happen,arrange is always NOT nan,measure with nan all convert to .Auto")
        }

        // loop until satisfy minWidth or maxWidth
        satisfyWidthLoop: while true {
            let starSpace = remainSpace / totalStar

            for (arrayIndex, (index: defIndex, def: def)) in starDefinitions.enumerated() {
                if case let .Star(star, minSpace, maxSpace) = def {
                    let cellSpace = star * starSpace
                    if let minSpace = minSpace {
                        if minSpace > cellSpace {
                            splitResult[defIndex] = minSpace
                            totalStar -= star
                            remainSpace -= minSpace
                            starDefinitions.remove(at: arrayIndex)
                            continue satisfyWidthLoop
                        }
                    }
                    if let maxSpace = maxSpace {
                        if maxSpace < cellSpace {
                            splitResult[defIndex] = maxSpace
                            totalStar -= star
                            remainSpace -= maxSpace
                            starDefinitions.remove(at: arrayIndex)
                            continue satisfyWidthLoop
                        }
                    }
                    splitResult[defIndex] = cellSpace
                }
            }
            break // no width unsatisfy, end loop
        }

        return splitResult
    }
}
