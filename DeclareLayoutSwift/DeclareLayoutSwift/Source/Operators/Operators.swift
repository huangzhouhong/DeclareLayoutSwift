//
//  File.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/5.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

// extension Layoutable {
//    func with(_ initBlock: (Self) -> Void) -> Self {
//        initBlock(self)
//        return self
//    }
// }

public extension NSObjectProtocol {
    func with(_ initBlock: (Self) -> Void) -> Self {
        initBlock(self)
        return self
    }
    func outlet(_ param: inout Self)->Self {
        param = self
        return self
    }
    func outlet(_ param: inout Self?)->Self {
        param = self
        return self
    }
}

public func & (e1: Layoutable, e2: Layoutable) -> [Layoutable] {
    return [e1, e2]
}
public func & (e1: [Layoutable], e2: Layoutable) -> [Layoutable] {
    var e1 = e1
    e1.append(e2)
    return e1
}

// infix operator <-
infix operator <-: AssignmentPrecedence

// class PropertyName<TargetType, TargetPropertyType> {
//    let keyPath: WritableKeyPath<TargetType, TargetPropertyType>?
//    let method: String?
//    init(keyPath: WritableKeyPath<TargetType, TargetPropertyType>? = nil, method: String? = nil) {
//        self.keyPath = keyPath
//        self.method = method
//    }
//
//    static var horizontalAlignment: PropertyName<Layoutable, HorizontalAlignment?> {
//        return PropertyName<Layoutable, HorizontalAlignment?>(keyPath: \Layoutable.horizontalAlignment)
//    }
//    static var verticalAlignment: PropertyName<Layoutable, VerticalAlignment?> {
//        return PropertyName<Layoutable, VerticalAlignment?>(keyPath: \Layoutable.verticalAlignment)
//    }
//    static var width: PropertyName<Layoutable, CGFloat?> {
//        return PropertyName<Layoutable, CGFloat?>(keyPath: \Layoutable.width)
//    }
//    static var height: PropertyName<Layoutable, CGFloat?> {
//        return PropertyName<Layoutable, CGFloat?>(keyPath: \Layoutable.height)
//    }
//    static var margin: PropertyName<Layoutable, UIEdgeInsets?> {
//        return PropertyName<Layoutable, UIEdgeInsets?>(keyPath: \Layoutable.margin)
//    }
//    static var padding: PropertyName<Layoutable, UIEdgeInsets?> {
//        return PropertyName<Layoutable, UIEdgeInsets?>(keyPath: \Layoutable.padding)
//    }
//
//    // for Grid
//    // [Grid.Definition]! or [Grid.Definition]? cause error, bug?
//    static var rows: PropertyName<Grid, ImplicitlyUnwrappedOptional<[Grid.Definition]>> {
//        return PropertyName<Grid, ImplicitlyUnwrappedOptional<[Grid.Definition]>>(keyPath: \Grid.rows)
//    }
//    static var columns: PropertyName<Grid, ImplicitlyUnwrappedOptional<[Grid.Definition]>> {
//        return PropertyName<Grid, ImplicitlyUnwrappedOptional<[Grid.Definition]>>(keyPath: \Grid.columns)
//    }
//    static var gridRowIndex: PropertyName<Layoutable, Int> {
//        return PropertyName<Layoutable, Int>(method: "row")
//    }
//    static var gridColumnIndex: PropertyName<Layoutable, Int> {
//        return PropertyName<Layoutable, Int>(method: "column")
//    }
//
//    // stackpanel
//    static var orientation: PropertyName<StackPanel, StackPanel.Orientation> {
//        return PropertyName<StackPanel, StackPanel.Orientation>(keyPath: \StackPanel.orientation)
//    }
//
//    // for Views
//    static var text: PropertyName<NSObject, String?> {
//        return PropertyName<NSObject, String?>(method: "text")
//    }
//    static var title: PropertyName<UIButton, String?> {
//        return PropertyName<UIButton, String?>(method: "title")
//    }
//
//    static var tableDelegate: PropertyName<TableElement, TableElementDelegate?> {
//        return PropertyName<TableElement, TableElementDelegate?>(keyPath: \TableElement.delegate)
//    }
// }
//
// infix operator <-
//
// protocol PropertySetterProtocol {
//    func setValueForTarget(_ target: Any)
// }
//
// class PropertySetter<TargetType, TargetPropertyType>: PropertySetterProtocol {
////    var targetKeyPath: WritableKeyPath<TargetType, TargetPropertyType>
//    var propertyName: PropertyName<TargetType, TargetPropertyType>
//    var value: TargetPropertyType
//    init(propertyName: PropertyName<TargetType, TargetPropertyType>, value: TargetPropertyType) {
////        SpeedLog.print(targetKeyPath, value)
//        self.propertyName = propertyName
//        self.value = value
//    }
//
//    func setValueForTarget(_ target: Any) {
//        if let targetKeyPath = propertyName.keyPath {
//            if var t = target as? TargetType {
//                t[keyPath: targetKeyPath] = value
//            }
//        } else if let method = propertyName.method {
//            switch method {
//            case "title":
//                if let button = target as? UIButton {
//                    button.setTitle(value as? String, for: .normal)
//                }
//            case "text":
//                if let t = target as? NSObject {
//                    t.perform(#selector(setter: UILabel.text), with: value)
//                }
//            case "row":
//                if let ele = target as? Layoutable,
//                    let index = value as? Int {
//                    Grid.setRow(ele: ele, row: index)
//                }
//            case "column":
//                if let ele = target as? Layoutable,
//                    let index = value as? Int {
//                    Grid.setColumn(ele: ele, column: index)
//                }
//            default:
//                fatalError()
//                break
//            }
//        }
//    }
// }
//
// func <- <TargetType, TargetPropertyType>(p1: PropertyName<TargetType, TargetPropertyType>, p2: TargetPropertyType) -> PropertySetterProtocol {
//    return PropertySetter<TargetType, TargetPropertyType>(propertyName: p1, value: p2)
// }
//
// extension Array where Element == PropertySetterProtocol {
//    func setupForTarget(_ target: Any) {
//        for propertySetter in self {
//            propertySetter.setValueForTarget(target)
//        }
//    }
// }
