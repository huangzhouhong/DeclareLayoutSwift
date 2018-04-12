//
//  UIViewController+TitleView.swift
//  Dingding
//
//  Created by 黄周鸿 on 2018/3/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

extension UIViewController {
    func createTitleView(title: String, buttons: [Layoutable]) {
        navigationController?.navigationBar.barTintColor = .white

        let titleView = HostView {
            LinearGrid(.columns <- [.star(1), .auto], .context <- self)[
                Label(.text <- title, .fontSize <- 20),
                StackPanel(.orientation <- .Horizontal, .children <- buttons)
            ]
        }
        navigationItem.titleView = titleView
    }
}
