//
//  HomePageDelegate.swift
//  Juejin
//
//  Created by 黄周鸿 on 2018/4/9.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class HomePageDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = "标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题"
        let content = "内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容"
        let element = StackPanel(.margin <- Insets(14))[
            Grid(.columns <- [.auto, .star(1), .auto])[
                Image(.image <- #imageLiteral(resourceName: "avatar"), .margin <- Insets(right: 5)),
                Label(.text <- "samuel", .gridColumnIndex <- 1),
                Label(.text <- "这是类别", .gridColumnIndex <- 2, .textColor <- 0x8A9BA8)
            ],
            Label(.text <- title, .margin <- Insets(top: 12, bottom: 8), .numberOfLines <- 0, .fontSize <- 19),
            Label(.text <- content, .margin <- Insets(bottom: 12), .numberOfLines <- 0, .fontSize <- 15, .textColor <- 0x2E3236),
            StackPanel(.orientation <- .Horizontal)[
                Image(.image <- #imageLiteral(resourceName: "heart")),
                Label(.text <- "11", .margin <- Insets(left: 4, right: 20)),
                Image(.image <- #imageLiteral(resourceName: "comment")),
                Label(.text <- "4", .margin <- Insets(left: 4))
            ]
        ]

        return tableView.makeCell(element: element)
    }
}
