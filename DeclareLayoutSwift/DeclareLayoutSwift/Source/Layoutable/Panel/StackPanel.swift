//
//  StackPanel.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/26.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

public class StackPanel : Panel{
    public enum  Orientation{
        case Vertical
        case Horizontal
    }
        
    var orientation:Orientation = .Vertical
    
//    override func setup() {
//        setupForGrid()
//        super.setup()
//    }
//
//    func setupForGrid(){
//        let defs = [Definition](repeating:.Auto(min: nil, max: nil),count:children.count)
//        let vertical = orientation == .Vertical
//        let handler = vertical ? Grid.setRow : Grid.setColumn
//        if vertical {
//            rows=defs
//        }else{
//            columns=defs
//        }
//
//        for (index,child) in children.enumerated(){
//            handler(child,index)
//        }
//
////        if orientation == .Vertical{
////            rows=defs
////            for child in
////        }else{
////            columns=defs
////        }
//    }
    public convenience init(_ propertySetters: PropertySetter<StackPanel>..., createChildren: () -> [Layoutable]) {
        self.init(createChildren: createChildren)
        propertySetters.forEach { $0.setter(self)}
    }
    
    override public func measure(_ availableSize: DLSize) {
        var width:CGFloat=0
        var height:CGFloat=0
        
        let processChildSize = orientation == .Vertical ? processChildSizeVertical : processChildSizeHorizontal
        
        for child in children{
            child.measure(DLSize.nan)
            processChildSize(child, &width, &height)
        }
        
        desiredSize = CGSize(width: width, height: height)
    }
    
    func processChildSizeVertical(child:Layoutable,width:inout CGFloat,height:inout CGFloat){
        let childWidth:CGFloat = child.width ?? child.desiredSize.width
        let childHeight:CGFloat = child.height ?? child.desiredSize.height
        
        width = max(width, childWidth)
        height += childHeight
    }
    
    func processChildSizeHorizontal(child:Layoutable,width:inout CGFloat,height:inout CGFloat){
        let childWidth:CGFloat = child.width ?? child.desiredSize.width
        let childHeight:CGFloat = child.height ?? child.desiredSize.height
        
        width += childWidth
        height = max(height, childHeight)
    }

    override public func arrange(_ finalRect: CGRect) {
        if orientation == .Vertical {
            arrangeVertical(finalRect)
        }else{
            arrangeHorizontal(finalRect)
        }
    }
    
    func arrangeVertical(_ finalRect: CGRect) {
        assert(orientation == .Vertical)
        
        var y=finalRect.minY
        let width = finalRect.width
        for child in children{
            var childWidth = child.width ?? child.desiredSize.width
            let childHeight = child.height ?? child.desiredSize.height
            let align = child.horizontalAlignment ?? .Stretch
            var x = finalRect.minX
            switch align{
            case .Right:
                x += width - childWidth
            case .Center:
                x += (width - childWidth) / 2
            case .Stretch:
                childWidth=width
            default:break
            }
            child.arrange(CGRect(x: x, y: y, width: childWidth, height: childHeight))
            y += childHeight
        }
    }
    
    func arrangeHorizontal(_ finalRect: CGRect) {
        assert(orientation == .Horizontal)
        
        var x=finalRect.minX
        let height = finalRect.height
        for child in children{
            let childWidth = child.width ?? child.desiredSize.width
            var childHeight = child.height ?? child.desiredSize.height
            let align = child.verticalAlignment ?? .Stretch
            var y=finalRect.minY
            switch align{
            case .Bottom:
                y += height - childHeight
            case .Center:
                y += (height-childHeight) / 2
            case .Stretch:
                childHeight=height
            default:break
            }
            
            child.arrange(CGRect(x: x, y: y, width: childWidth, height: childHeight))
            x += childWidth
        }
    }
}
