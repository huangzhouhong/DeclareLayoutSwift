//
//  QQMsgVC.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class QQMsgVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    struct QQChatItem {
        var iconName: String
        var name: String
        var lastMsg: String
        var time: String
    }

    var tableData: [QQChatItem]!

    override func viewDidLoad() {
        super.viewDidLoad()
        let t = QQChatItem(iconName: "osx", name: "Test", lastMsg: "last message", time: "AM 11:54")
        tableData = [QQChatItem](repeating: t, count: 20)

        view.backgroundColor = .white
        view.hostElement {
            Table(.delegate <- self, .dataSource <- self)
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = tableData[indexPath.row]
        let element = Grid(.columns <- [.auto, .star(1)], .padding <- Insets(vertical: 8, horizontal: 20))[
            Image(.width <- 50, .image <- rowData.iconName, .margin <- Insets(right: 10)),
            StackPanel(.gridColumnIndex <- 1)[
                Grid(.columns <- [.star(1), .auto])[
                    Label(.text <- rowData.name, .fontSize <- 17),
                    Label(.gridColumnIndex <- 1, .text <- rowData.time, .fontSize <- 13, .textColor <- "#cccccc")
                ] ,
                Label(.text <- rowData.lastMsg, .fontSize <- 15, .textColor <- UIColor.gray)
            ]
        ]

        return tableView.makeCell(element: element)
    }
}
