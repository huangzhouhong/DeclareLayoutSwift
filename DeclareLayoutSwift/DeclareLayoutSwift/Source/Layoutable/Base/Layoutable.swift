//
//  Layoutable.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/10.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

// TODO: Collapsed not implemented
public enum Visibility {
    case Collapsed, Hidden, Visible
}

public protocol Layoutable: class, SupportStoreProperty {
    var desiredSize: CGSize { get }
    var horizontalAlignment: HorizontalAlignment? { get set }
    var verticalAlignment: VerticalAlignment? { get set }
    var width: CGFloat? { get set }
    var height: CGFloat? { get set }

    var margin: UIEdgeInsets? { get set }
    var padding: UIEdgeInsets? { get set }

    var children: [Layoutable] { get set }
    var parent: Layoutable? { get set }
    var context: AnyObject? { get set }
    var visibility: Visibility { get set }

    // not all child measured, parent measure is designed to get itself desireSize
    var measured: Bool { get set }

    func setup()
    func measure(_ availableSize: DLSize)
    func arrange(_ finalRect: CGRect)
}
