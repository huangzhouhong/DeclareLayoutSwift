//
//  UIViewController+TitleView.swift
//  Dingding
//
//  Created by 黄周鸿 on 2018/3/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import  UIKit
import DeclareLayoutSwift

extension UIViewController{
    func createTitleView(title:String){
        self.navigationController?.navigationBar.barTintColor = .white
        let titleView = HostView {
            Grid {
                [Label(.text <- title, .fontSize <- 20),
                 StackPanel(.orientation <- .Horizontal, .hAlign <- .Right) {
                    [Button(.image <- #imageLiteral(resourceName: "Msg_nav1")),
                     Button(.image <- #imageLiteral(resourceName: "Msg_nav2"), .margin <- Insets(vertical: 0, horizontal: 20)),
                     Button(.image <- #imageLiteral(resourceName: "Msg_nav3"))]
                    }]
            }
        }
        self.navigationItem.titleView = titleView
    }
}
