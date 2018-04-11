//
//  DisposeBag.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/4/10.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import Foundation

private class DisposeBag {
    var objs: [AnyObject] = []
}

private var disposeBagKey: Int = 0

public protocol SupportDisposeBag: SupportStoreProperty {}

extension SupportDisposeBag {
    fileprivate var disposeBag: DisposeBag {
        get {
            if let value = getValue(key: &disposeBagKey) as? DisposeBag {
                return value
            } else {
                let value = DisposeBag()
                setValue(key: &disposeBagKey, value: value)
                return value
            }
        }
        set {
            setValue(key: &disposeBagKey, value: newValue)
        }
    }
}

extension NSObject: SupportDisposeBag {}

public extension NSObject {
    func retain(owner: SupportDisposeBag) {
        owner.disposeBag.objs.append(self)
    }
}
