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
    func createTitleView(title: String) {
        self.navigationController?.navigationBar.barTintColor = .white
        let titleView = HostView {
            Grid(.columns <- [.star(1), .auto]) {
                [Label(.text <- title, .fontSize <- 20),
                 StackPanel(.gridColumnIndex <- 1, .orientation <- .Horizontal) {
                     [Button(.image <- #imageLiteral(resourceName: "Msg_nav1")),
                      Button(.image <- #imageLiteral(resourceName: "Msg_nav2"), .margin <- Insets(vertical: 0, horizontal: 20)),
                      Button(.image <- #imageLiteral(resourceName: "Msg_nav3"))]
                }]
            }
        }
        self.navigationItem.titleView = titleView
    }
}
