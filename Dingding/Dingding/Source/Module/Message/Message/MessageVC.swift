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
            Button {
                $0.setImage(#imageLiteral(resourceName: "Msg_nav1"), for: .normal)
                $0.addTarget(self, action: #selector(self.onTap), for: .touchUpInside)
            },
            Button(.margin <- Insets(vertical: 0, horizontal: 20)) {
                $0.setImage(#imageLiteral(resourceName: "Msg_nav2"), for: .normal)
                $0.addTarget(self, action: #selector(self.onTap), for: .touchUpInside)
            },
            Button {
                $0.setImage(#imageLiteral(resourceName: "Msg_nav3"), for: .normal)
                $0.addTarget(self, action: #selector(self.onTap), for: .touchUpInside)
            }
        ]

        createTitleView(title: "钉钉", buttons: titleButtons)

        hostElement {
            Table {
                $0.delegate = self
                $0.dataSource = self
            }
        }
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        let element = LinearGrid(.columns <- [.auto, .star(1)], .padding <- Insets(vertical: 8, horizontal: 20))[
            Image(.width <- 50, .margin <- Insets(right: 10)) { $0.image = #imageLiteral(resourceName: "Msg_List") },
            StackPanel()[
                LinearGrid(.columns <- [.star(1), .auto])[
                    Label {
                        $0.text = "钉钉运动"
                        $0.font = UIFont.systemFont(ofSize: 17)
                    },
                    Label {
                        $0.text = "下午 8:36"
                        $0.font = UIFont.systemFont(ofSize: 13)
                        $0.textColor = UIColor("#cccccc")
                    }
                ],
                Label(.margin <- Insets(top: 8)) {
                    $0.text = "IT技术中心 获得3月24日 XXX有限公司全员步数第一"
                    $0.font = UIFont.systemFont(ofSize: 15)
                    $0.textColor = .gray
                }
            ]
        ]

        return tableView.makeCell(element: element)
    }

    @objc func onTap() {
        SpeedLog.print("ok")
    }
}
