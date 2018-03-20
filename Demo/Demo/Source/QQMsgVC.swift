//
//  QQMsgVC.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class QQMsgVC: SafeAreaVC, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = tableData[indexPath.row]
        let element = Grid(.columns <- [.auto, .star(1)], .padding <- Insets(vertical: 8, horizontal: 20)) {
            [Image(.width <- 50, .image <- rowData.iconName, .margin <- Insets(right: 10)),
             StackPanel(.gridColumnIndex <- 1) {
                 [Grid(.columns <- [.star(1), .auto]) {
                     [Label(.text <- rowData.name, .fontSize <- 17),
                      Label(.gridColumnIndex <- 1, .text <- rowData.time, .fontSize <- 13, .textColor <- UIColor(white: 0.8, alpha: 1))]
                 },
                 Label(.text <- rowData.lastMsg, .fontSize <- 15, .textColor <- .gray)]

            }]
        }
        return tableView.makeCell(element: element, indexPath: indexPath)
//        return Grid(.columns <- [.auto, .star(1)],.padding <- Insets(vertical: 8, horizontal: 20)) {
//            [ImageView(.width <- 50,.image <- self.rounedImage(name: rowData.iconName),.margin <- Insets(right:10)) ,
//             StackPanel(.gridColumnIndex <- 1) {
//                [Grid(.columns <- [.star(1), .auto]) {
//                    [Label(.text <- rowData.name,.fontSize <- 17),
//                     Label(.gridColumnIndex <- 1, .text <- rowData.time,.fontSize <- 13,.textColor <- UIColor(white: 0.8, alpha: 1))]
//                },
//                 Label(.text <- rowData.lastMsg,.fontSize <- 15,.textColor <- .gray)]
//            }]
//        }
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.heightForIndexPath(indexPath)
//    }

//    func rounedImage(name:String) -> UIImage {
//        let image = UIImage(named: name)!
//        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
//        UIGraphicsBeginImageContextWithOptions(image.size, false, 1)
//        UIBezierPath(
//            roundedRect: rect,
//            cornerRadius: image.size.height
//        ).addClip()
//        image.draw(in: rect)
//        return UIGraphicsGetImageFromCurrentImageContext()!
//    }

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

        setupHostView {
            HostView {
                Table(.delegate <- self, .dataSource <- self)
            }
        }
    }
}
