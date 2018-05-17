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
            Table {
                $0.delegate = self
                $0.dataSource = self
            }
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
            Label(.width <- 30, .height <- 30, .vAlign <- .Center) {
                $0.text = String(indexPath.row + 1)
                $0.backgroundColor = .red
                $0.layer.cornerRadius = 15
                $0.textColor = .white
                $0.textAlignment = .center
            },
            Label(.margin <- Insets(left: 8)) {
                $0.text = randString
                $0.numberOfLines = 0
            }
        ]

        return tableView.makeCell(element: element)
    }
}
