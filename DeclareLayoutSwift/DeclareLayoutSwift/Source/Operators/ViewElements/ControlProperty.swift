//
//  ControlProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/6.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

public enum ControlPropertyName {
    case touchDown,
    touchDownRepeat,
    touchDragInside,
    touchDragOutside,
    touchDragEnter,
    touchDragExit,
    touchUpInside,
    touchUpOutside,
    touchCancel,
    valueChanged,
    primaryActionTriggered,
    editingDidBegin,
    editingChanged,
    editingDidEnd,
    editingDidEndOnExit,
    allTouchEvents,
    allEditingEvents,
    applicationReserved,
    systemReserved,
    allEvents

}

public class ControlProperty<TargetPropertyType>: PropertyBase<ControlPropertyName> {
    public static var touchDown: ControlProperty<Any?> {
        return ControlProperty<Any?>(.touchDown)
    }
    public static var touchDownRepeat: ControlProperty<Any?> {
        return ControlProperty<Any?>(.touchDownRepeat)
    }
    public static var touchDragInside: ControlProperty<Any?> {
        return ControlProperty<Any?>(.touchDragInside)
    }
    public static var touchDragOutside: ControlProperty<Any?> {
        return ControlProperty<Any?>(.touchDragOutside)
    }
    public static var touchDragEnter: ControlProperty<Any?> {
        return ControlProperty<Any?>(.touchDragEnter)
    }
    public static var touchDragExit: ControlProperty<Any?> {
        return ControlProperty<Any?>(.touchDragExit)
    }
    public static var touchUpInside: ControlProperty<Any?> {
        return ControlProperty<Any?>(.touchUpInside)
    }
    public static var touchUpOutside: ControlProperty<Any?> {
        return ControlProperty<Any?>(.touchUpOutside)
    }
    public static var touchCancel: ControlProperty<Any?> {
        return ControlProperty<Any?>(.touchCancel)
    }
    public static var valueChanged: ControlProperty<Any?> {
        return ControlProperty<Any?>(.valueChanged)
    }
    public static var primaryActionTriggered: ControlProperty<Any?> {
        return ControlProperty<Any?>(.primaryActionTriggered)
    }
    public static var editingDidBegin: ControlProperty<Any?> {
        return ControlProperty<Any?>(.editingDidBegin)
    }
    public static var editingChanged: ControlProperty<Any?> {
        return ControlProperty<Any?>(.editingChanged)
    }
    public static var editingDidEnd: ControlProperty<Any?> {
        return ControlProperty<Any?>(.editingDidEnd)
    }
    public static var editingDidEndOnExit: ControlProperty<Any?> {
        return ControlProperty<Any?>(.editingDidEndOnExit)
    }
    public static var allTouchEvents: ControlProperty<Any?> {
        return ControlProperty<Any?>(.allTouchEvents)
    }
    public static var allEditingEvents: ControlProperty<Any?> {
        return ControlProperty<Any?>(.allEditingEvents)
    }
    public static var applicationReserved: ControlProperty<Any?> {
        return ControlProperty<Any?>(.applicationReserved)
    }
    public static var systemReserved: ControlProperty<Any?> {
        return ControlProperty<Any?>(.systemReserved)
    }
    public static var allEvents: ControlProperty<Any?> {
        return ControlProperty<Any?>(.allEvents)
    }
}

public func <- <TargetType, TargetPropertyType, ViewType>(property: ControlProperty<TargetPropertyType>, value: TargetPropertyType) -> PropertySetter<TargetType> where TargetType: ViewElement<ViewType>, ViewType: UIControl {
    let propertyName = property.propertyName
    let event:UIControlEvents
    switch propertyName {
    case .touchDown:
        event = .touchDown
    case .touchDownRepeat:
        event = .touchDownRepeat
    case .touchDragInside:
        event = .touchDragInside
    case .touchDragOutside:
        event = .touchDragOutside
    case .touchDragEnter:
        event = .touchDragEnter
    case .touchDragExit:
        event = .touchDragExit
    case .touchUpInside:
        event = .touchUpInside
    case .touchUpOutside:
        event = .touchUpOutside
    case .touchCancel:
        event = .touchCancel
    case .valueChanged:
        event = .valueChanged
    case .primaryActionTriggered:
        event = .primaryActionTriggered
    case .editingDidBegin:
        event = .editingDidBegin
    case .editingChanged:
        event = .editingChanged
    case .editingDidEnd:
        event = .editingDidEnd
    case .editingDidEndOnExit:
        event = .editingDidEndOnExit
    case .allTouchEvents:
        event = .allTouchEvents
    case .allEditingEvents:
        event = .allEditingEvents
    case .applicationReserved:
        event = .applicationReserved
    case .systemReserved:
        event = .systemReserved
    case .allEvents:
        event = .allEvents
    }
    
    return PropertySetter<TargetType>(setter: {
        element in
        if let selector = value as? Selector {
            element.addAction(action: selector, for: event)
        } else if let string = value as? String {
            element.addAction(action: NSSelectorFromString(string), for: event)
        } else {
            element.removeAction(controlEvents: event)
        }
    })
    

}
