//
//  File.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/5.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

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

//public func & (e1: Layoutable, e2: Layoutable) -> [Layoutable] {
//    return [e1, e2]
//}
//public func & (e1: [Layoutable], e2: Layoutable) -> [Layoutable] {
//    var e1 = e1
//    e1.append(e2)
//    return e1
//}

infix operator <-: AssignmentPrecedence
