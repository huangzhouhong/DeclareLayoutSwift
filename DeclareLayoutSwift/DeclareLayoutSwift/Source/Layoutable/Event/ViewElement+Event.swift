//
//  ViewElement+ControlEvent.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/2.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

class ViewElementEventStore: NSObject {
    var addSelectorForEvents: [UInt: Selector] = [:]
//    var target: AnyObject?
}

protocol SupportControlEvent {
    func setupControlEvent()
}

extension ViewElement: SupportControlEvent where ViewType: UIControl {
    
    var store: ViewElementEventStore {
        return getExtStore()
    }
    
    func setupControlEvent() {
        if let target = context {
            SpeedLog.print(target)
            for (event, selector) in store.addSelectorForEvents {
                if target.responds(to: selector) {
                    view.addTarget(target, action: selector, for: UIControlEvents(rawValue: event))
                } else {
                    fatalError("error: target for type:\(type(of: target)) not response for selector \(selector)")
                }
            }
        }
    }
    
    public func addAction(action: Selector, for controlEvents: UIControlEvents) {
        store.addSelectorForEvents[controlEvents.rawValue] = action
    }
    
    public func removeAction(controlEvents: UIControlEvents) {
        guard let target = context else {
            return
        }
        
        let selector = store.addSelectorForEvents.removeValue(forKey: controlEvents.rawValue)
        if let selector = selector {
            view.removeTarget(target, action: selector, for: controlEvents)
        }
    }
    
//    func findVC() -> UIViewController? {
//        var parentResponder: UIResponder? = view
//        while parentResponder != nil {
//            parentResponder = parentResponder!.next
//            if let viewController = parentResponder as? UIViewController {
//                return viewController
//            }
//        }
//        return nil
//    }
}
