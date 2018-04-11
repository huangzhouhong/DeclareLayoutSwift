//
//  SupportStoreProperty.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/3.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

public protocol SupportStoreProperty {}

public extension SupportStoreProperty {
    func getValue(key: UnsafeRawPointer) -> Any? {
        return objc_getAssociatedObject(self, key)
    }

    func setValue(key: UnsafeRawPointer, value: Any?) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
}

private var defaultStoreKey: UInt8 = 0

public extension SupportStoreProperty {
    func getExtStore<StoreType>(key: UnsafeRawPointer? = nil) -> StoreType where StoreType: NSObject {
        /* getExtStore<AAA> then getExtStore<BBB> by accident
         e.g. in different extension */
        if let key = key {
            // if user set key, use the key
            if let s = getValue(key: key) as? StoreType {
                return s
            } else {
                let s = StoreType()
                setValue(key: key, value: s)
                return s
            }
        } else {
            let s = getValue(key: &defaultStoreKey)
            if s != nil {
                if let s = s as? StoreType {
                    return s
                } else {
                    fatalError("use different type of StoreType. explicit set key of this method to resolve")
                }
            } else {
                let s = StoreType()
                setValue(key: &defaultStoreKey, value: s)
                return s
            }
        }

    }
}
