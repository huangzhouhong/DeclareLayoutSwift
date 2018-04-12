//
//  TableVC.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/1.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class TableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.hostElement {
            Table(.delegate <- self, .dataSource <- self)
        }
    }

    private func generateRandomString() -> String {
        let text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomIndex = arc4random_uniform(UInt32(text.count))
        let index = text.index(text.startIndex, offsetBy: Int(randomIndex))
        return String(text[...index])
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let randString = generateRandomString()

        let element = LinearGrid(.columns <- [.auto, .star(1)], .padding <- Insets(vertical: 8, horizontal: 20))[
            Label(.text <- String(indexPath.row + 1), .bgColor <- UIColor.red, .width <- 30, .height <- 30, .vAlign <- .Center, .cornerRadius <- 15, .textColor <- UIColor.white, .textAlignment <- .center),
            Label(.margin <- Insets(left: 8), .text <- randString, .numberOfLines <- 0)
        ]

        return tableView.makeCell(element: element)
    }
}
