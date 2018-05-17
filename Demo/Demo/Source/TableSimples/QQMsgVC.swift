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
            Table {
                $0.delegate = self
                $0.dataSource = self
            }
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = tableData[indexPath.row]

        let element = LinearGrid(.columns <- [.auto, .star(1)], .padding <- Insets(vertical: 8, horizontal: 20))[
            Image(.width <- 50, .margin <- Insets(right: 10)) {
                $0.image = UIImage(named: rowData.iconName)
            },
            StackPanel()[
                LinearGrid(.columns <- [.star(1), .auto])[
                    Label {
                        $0.text = rowData.name
                        $0.font = UIFont.systemFont(ofSize: 17)
                    },
                    Label {
                        $0.text = rowData.time
                        $0.font = UIFont.systemFont(ofSize: 13)
                        $0.textColor = UIColor("#cccccc")
                    }
                ],
                Label {
                    $0.text = rowData.lastMsg
                    $0.font = UIFont.systemFont(ofSize: 15)
                    $0.textColor = .gray
                }
            ]
        ]

        return tableView.makeCell(element: element)
    }
}
