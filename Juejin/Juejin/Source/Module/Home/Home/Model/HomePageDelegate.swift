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
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        let title = "标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题"
        let content = "内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容"

        let element = StackPanel(.margin <- Insets(14))[
            LinearGrid(.columns <- [.auto, .star(1), .auto])[
                Image(.margin <- Insets(right: 5)) {
                    $0.image = #imageLiteral(resourceName: "avatar")
                },
                Label {
                    $0.text = "samuel"
                },
                Label {
                    $0.text = "这是类别"
                    $0.textColor = UIColor(0x8A9BA8)
                }
            ],
            Label(.margin <- Insets(top: 12, bottom: 8)) {
                $0.text = title
                $0.numberOfLines = 0
                $0.font = UIFont.systemFont(ofSize: 19)
            },
            Label(.margin <- Insets(bottom: 12)) {
                $0.text = content
                $0.numberOfLines = 0
                $0.font = UIFont.systemFont(ofSize: 15)
                $0.textColor = UIColor(0x2E3236)
            },
            StackPanel(.orientation <- .Horizontal)[
                Image {
                    $0.image = #imageLiteral(resourceName: "heart")
                },
                Label(.margin <- Insets(left: 4, right: 20)) {
                    $0.text = "11"
                },
                Image {
                    $0.image = #imageLiteral(resourceName: "comment")
                },
                Label(.margin <- Insets(left: 4)) {
                    $0.text = "4"
                }
            ]
        ]

        return tableView.makeCell(element: element)
    }
}
