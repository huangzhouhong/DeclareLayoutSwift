//
//  KeyValueObserver.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/5/10.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

// remove `observeValue` and `removeObserver` from your code
public class KeyValueObserver : NSObject{
    weak var object:NSObject?
    var keyPath:String
    weak var target:NSObject?
    var selector:String // convert to string to prevent retain cycle
    
    public init(object:NSObject,keyPath:String,target:NSObject,selector:Selector,options: NSKeyValueObservingOptions = []){
        self.object = object
        self.keyPath = keyPath
        self.target = target
        self.selector = NSStringFromSelector(selector)
        super.init()
        object.addObserver(self, forKeyPath: keyPath, options: options, context: nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as? NSObject == self.object{
            notifyTarget(change: change)
        }
    }
    
    func notifyTarget(change: [NSKeyValueChangeKey : Any]?){
        _ = target?.perform(NSSelectorFromString(selector), with: change)
    }
    
    deinit {
        object?.removeObserver(self, forKeyPath: keyPath)
    }
}
