//
//  StackPanel.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/26.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

public class StackPanel: Panel {
    public enum Orientation {
        case Vertical
        case Horizontal
    }
    
    var orientation: Orientation = .Vertical
    
    public init(_ propertySetters: PropertySetter<StackPanel>..., createChildren: (() -> [Layoutable])? = nil) {
        super.init(createChildren)
        propertySetters.forEach { $0.setter(self) }
    }
    
    override func measureOverwrite(_ availableSize: DLSize) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        
//        let processChildSize = orientation == .Vertical ? processChildSizeVertical : processChildSizeHorizontal
//        let availableWidth = orientation == .Vertical ? availableSize.width : CGFloat.nan
//        let availableHeight = orientation == .Horizontal ? availableSize.height : CGFloat.nan
//
//        for child in children {
//            child.measure(DLSize(width: availableWidth, height: availableHeight))
//            processChildSize(child, &width, &height)
//        }
        
        if orientation == .Vertical {
            for child in children {
                let childAlign = child.horizontalAlignment ?? .Stretch
                let availableWidth = childAlign == .Stretch ? availableSize.width : CGFloat.nan
                child.measure(DLSize(width: availableWidth, height: CGFloat.nan))
                width = max(width, child.desiredSize.width)
                height += child.desiredSize.height
            }
        } else {
            for child in children {
                let childAlign = child.verticalAlignment ?? .Stretch
                let availableHeight = childAlign == .Stretch ? availableSize.height : CGFloat.nan
                child.measure(DLSize(width: CGFloat.nan, height: availableHeight))
                width += child.desiredSize.width
                height = max(height, child.desiredSize.height)
            }
        }
        
        return CGSize(width: width, height: height)
    }
    
//    func processChildSizeVertical(child: Layoutable, width: inout CGFloat, height: inout CGFloat) {
//        let childWidth: CGFloat = child.width ?? child.desiredSize.width
//        let childHeight: CGFloat = child.height ?? child.desiredSize.height
//
//        width = max(width, childWidth)
//        height += childHeight
//    }
//
//    func processChildSizeHorizontal(child: Layoutable, width: inout CGFloat, height: inout CGFloat) {
//        let childWidth: CGFloat = child.width ?? child.desiredSize.width
//        let childHeight: CGFloat = child.height ?? child.desiredSize.height
//
//        width += childWidth
//        height = max(height, childHeight)
//    }
    
    override func arrangeOverwrite(rect: CGRect, innerRect: CGRect) {
        if orientation == .Vertical {
            arrangeVertical(innerRect)
        } else {
            arrangeHorizontal(innerRect)
        }
    }
    
    func arrangeVertical(_ finalRect: CGRect) {
        assert(orientation == .Vertical)
        
        var y = finalRect.minY
        let width = finalRect.width
        for child in children {
            let childAlign = child.horizontalAlignment ?? .Stretch
            var childWidth = width
            if childAlign != .Stretch {
//                if let explictWidth = child.width {
//                    childWidth = explictWidth
//                } else {
                if !child.measured {
                    child.measure(DLSize(width: CGFloat.nan, height: CGFloat.nan))
                }
                childWidth = child.desiredSize.width
//                }
            }
            
            var childHeight: CGFloat
//            if let explictHeight = child.height {
//                childHeight = explictHeight + (child.margin?.vSpace ?? 0)
//            } else {
            if !child.measured {
                child.measure(DLSize(width: childWidth, height: CGFloat.nan))
            }
            childHeight = child.desiredSize.height
//            }
            
            var x = finalRect.minX
            switch childAlign {
            case .Right:
                x += width - childWidth
            case .Center:
                x += (width - childWidth) / 2
            //            case .Stretch:
            //                childWidth = width
            default: break
            }
            child.arrange(CGRect(x: x, y: y, width: childWidth, height: childHeight))
            y += childHeight
        }
    }
    
    func arrangeHorizontal(_ finalRect: CGRect) {
        assert(orientation == .Horizontal)
        
        var x = finalRect.minX
        let height = finalRect.height
        for child in children {
            let childAlign = child.verticalAlignment ?? .Stretch
            
            var childHeight = height
            if childAlign != .Stretch {
//                if let explictHeight = child.height {
//                    childHeight = explictHeight
//                } else {
                if !child.measured {
                    child.measure(DLSize(width: CGFloat.nan, height: CGFloat.nan))
                }
                childHeight = child.desiredSize.height
//                }
            }
            
//            var childWidth: CGFloat
//            if let explictWidth = child.width {
//                childWidth = explictWidth
//            } else {
            if !child.measured {
                child.measure(DLSize(width: CGFloat.nan, height: childHeight))
            }
            let childWidth = child.desiredSize.width
//            }
            
//            let childWidth = child.width ?? child.desiredSize.width
//            var childHeight = child.height ?? child.desiredSize.height
//            let align = child.verticalAlignment ?? .Stretch
            var y = finalRect.minY
            switch childAlign {
            case .Bottom:
                y += height - childHeight
            case .Center:
                y += (height - childHeight) / 2
            //            case .Stretch:
            //                childHeight = height
            default: break
            }
            
            child.arrange(CGRect(x: x, y: y, width: childWidth, height: childHeight))
            x += childWidth
        }
    }
}
