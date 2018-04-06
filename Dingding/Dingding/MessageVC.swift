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

        self.createTitleView(title: "钉钉")

        self.hostElement {
            Table(.delegate <- self, .dataSource <- self)
        }
    }

    @objc func onTap() {
        SpeedLog.print("ok")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = Grid(.columns <- [.auto, .star(1)], .padding <- Insets(vertical: 8, horizontal: 20)) {
            [Image(.width <- 50, .image <- #imageLiteral(resourceName: "Msg_List"), .margin <- Insets(right: 10)),
             StackPanel(.gridColumnIndex <- 1) {
                 [Grid(.columns <- [.star(1), .auto]) {
                     [Label(.text <- "钉钉运动", .fontSize <- 17),
                      Label(.gridColumnIndex <- 1, .text <- "下午 8:36", .fontSize <- 13, .textColor <- UIColor(white: 0.8, alpha: 1))]
                 },
                  Label(.text <- "IT技术中心 获得3月24日 XXX有限公司全员步数第一", .fontSize <- 15, .textColor <- .gray, .margin <- Insets(top: 8))]
            }]
        }
        return tableView.makeCell(element: element)
    }
}
