//
//  UIViewController+Inject.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/9.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

extension UIViewController { // 5
    #if DEBUG // 1
    @objc func injected() { // 2
        for subview in self.view.subviews { // 3
            subview.removeFromSuperview()
        }
        
        viewDidLoad() // 4
    }
    #endif
}
