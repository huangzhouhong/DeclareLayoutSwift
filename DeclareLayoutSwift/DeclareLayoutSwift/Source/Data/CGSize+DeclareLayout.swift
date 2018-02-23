//
//  CGSize+DeclareLayout.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/11.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

// custom size support store nan for width and height
public struct DLSize: CustomStringConvertible {
    public var description: String {
        return "(\(self.width),\(self.height))"
    }

    public var width: CGFloat
    public var height: CGFloat
}

public extension DLSize {
    // convert from CGSize
    init(_ cgSize: CGSize) {
        self.init(width: cgSize.width, height: cgSize.height)
    }

    static var zero: DLSize {
        return DLSize(width: 0, height: 0)
    }
    static var nan: DLSize {
        return DLSize(width: CGFloat.nan, height: CGFloat.nan)
    }

    mutating func addInset(inset: UIEdgeInsets?) {
        if let inset = inset {
            if !self.width.isNaN {
                self.width += inset.left + inset.right
            }
            if !self.height.isNaN {
                self.height += inset.top + inset.bottom
            }
        }
    }

    mutating func removeInset(inset: UIEdgeInsets?) {
        if let inset = inset {
            if !self.width.isNaN {
                self.width -= inset.left + inset.right
                self.width = Swift.max(0, self.width)
            }
            if !self.height.isNaN {
                self.height -= inset.top + inset.bottom
                self.height = Swift.max(0, self.height)
            }
        }
    }
}

public extension CGSize {
    init(_ dlSize: DLSize) {
//        if dlSize.width.isNaN || dlSize.height.isNaN {
//            fatalError("DLSize with nan can not convert to CGSize")
//        }
        let width = dlSize.width.isNaN ? CGFloat.greatestFiniteMagnitude : dlSize.width
        let height = dlSize.height.isNaN ? CGFloat.greatestFiniteMagnitude : dlSize.height
        self.init(width: width, height: height)
    }
}

public extension CGSize {
//    static var max: CGSize { return CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude) }
//    static var nan: CGSize {
//        return CGSize(width: CGFloat.nan, height: CGFloat.nan)
//    }
    mutating func addInset(inset: UIEdgeInsets?) {
        if let inset = inset {
            width += inset.left + inset.right
            height += inset.top + inset.bottom
        }
    }

    mutating func removeInset(inset: UIEdgeInsets?) {
        if let inset = inset {
            width -= inset.left + inset.right
            height -= inset.top + inset.bottom
            width = Swift.max(0, width)
            height = Swift.max(0, height)
        }
    }
}



public extension CGRect {
    func innerRectWithInset(_ inset: UIEdgeInsets?) -> CGRect {
        if let inset = inset {
            return UIEdgeInsetsInsetRect(self, inset)
        } else {
            return self
        }
    }
}
