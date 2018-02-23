//
//  ObservableArray.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/12.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import Foundation

public final class ObservableArray<T> : Collection, MutableCollection, CustomDebugStringConvertible {
    private var _elements: [T] = []
    
    public func index(after i: Int) -> Int {
        return _elements.index(after: i);
    }

    public var isEmpty: Bool {
        return _elements.isEmpty
    }
    
    public var count: Int {
        return _elements.count
    }
    
    public var startIndex: Int {
        return _elements.startIndex
    }
    
    public var endIndex: Int {
        return _elements.endIndex
    }
    
    public var first: T? {
        return _elements.first
    }
    
    public var last: T? {
       return _elements.last
    }
    
    public var debugDescription: String {
        return _elements.debugDescription
    }
    
    public subscript(index: Int) -> T {
        get {
            return _elements[index]
        }
        set {
            let oldValue=_elements[index]
            _elements[index] = newValue
            triggerChanged(operation: .Remove(oldValue))
            triggerChanged(operation: .Add(newValue))
        }
    }
    
    public func append(_ element: T) {
        _elements.append(element)
        triggerChanged(operation: .Add(element))
    }
    
    public func insert(_ element: T, at index : Int) {
        _elements.insert(element, at: index)
        triggerChanged(operation: .Add(element))
    }
    
    func remove(at position: Int) -> T {
        let element = _elements.remove(at: position)
        triggerChanged(operation: .Remove(element))
        return element;
    }
    
    enum Operation{
        case Add(T)
        case Remove(T)
    }
    
    var changed:((Operation)->Void)?
    
    func observe(changed:@escaping (Operation)->Void){
        self.changed = changed
    }
    
    func triggerChanged(operation:Operation){
        SpeedLog.print("triggerChanged:\(operation)")
        if let changed=changed{
            changed(operation)
        }
    }
}
