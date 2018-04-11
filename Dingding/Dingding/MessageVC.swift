//
//  ViewController.swift
//  Dingding
//
//  Created by 黄周鸿 on 2018/3/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class MessageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleButtons = [
            Button(.image <- #imageLiteral(resourceName: "Msg_nav1"), .touchDown <- "onTap"),
            Button(.image <- #imageLiteral(resourceName: "Msg_nav2"), .margin <- Insets(vertical: 0, horizontal: 20), .touchDown <- "onTap"),
            Button(.image <- #imageLiteral(resourceName: "Msg_nav3"), .touchDown <- #selector(self.onTap)),
        ]

        createTitleView(title: "钉钉", buttons: titleButtons)

        hostElement {
            Table(.delegate <- self, .dataSource <- self)
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        let element = Grid(.columns <- [.auto, .star(1)], .padding <- Insets(vertical: 8, horizontal: 20))[
            Image(.width <- 50, .image <- #imageLiteral(resourceName: "Msg_List"), .margin <- Insets(right: 10)),
            StackPanel(.gridColumnIndex <- 1)[
                Grid(.columns <- [.star(1), .auto])[
                    Label(.text <- "钉钉运动", .fontSize <- 17),
                    Label(.gridColumnIndex <- 1, .text <- "下午 8:36", .fontSize <- 13, .textColor <- "#cccccc")
                ],
                Label(.text <- "IT技术中心 获得3月24日 XXX有限公司全员步数第一", .fontSize <- 15, .textColor <- UIColor.gray, .margin <- Insets(top: 8))
            ]
        ]

        return tableView.makeCell(element: element)
    }

    @objc func onTap() {
        SpeedLog.print("ok")
    }
}
