//
//  ClassMainVC.swift
//  Demo
//
//  Created by 黄周鸿 on 2018/2/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class ClassMainVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, PagesDelegate {
    weak var table: Table!
    let images = ["banner1", "banner2", "banner3"]
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.hostElement {
            Table(.delegate <- self, .dataSource <- self).outlet(&table)
        }

        table.header = StackPanel()[
            Pages(.pagesDelegate <- self, .scrollDuration <- TimeInterval(2.0), .loop <- false),
            Items(.delegate <- self, .dataSource <- self, .bgColor <- UIColor.white, .itemMinHSpacing <- 0, .margin <- Insets(vertical: 10, horizontal: 20)),
            ViewElement(.bgColor <- 0xF0F0F0, .height <- 8)
        ]
    }

    // MARK: - PagesDelegate

    func pagesCellForItemAt(_ index: Int) -> UIElement {
        return Image(.image <- images[index])
    }

    func pageNumberOfItems() -> Int {
        return images.count
    }

    // MARK: - tableView

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let redDotSize: CGFloat = 6

        let showDot = indexPath.row % 2 == 0
        let visibility: Visibility = showDot ? .Visible : .Hidden

        let element = Grid(.columns <- [.auto(), .star(1)], .margin <- Insets(8))[
            View(.bgColor <- UIColor.red, .cornerRadius <- redDotSize / 2, .width <- redDotSize, .height <- redDotSize, .vAlign <- .Center, .margin <- Insets(10), .visibility <- visibility),
            StackPanel(.gridColumnIndex <- 1)[
                Grid(.columns <- [.star(1), .auto])[
                    Label(.text <- "今天", .fontSize <- 16, .margin <- Insets(bottom: 4)),
                    Label(.text <- "2018-01-01", .gridColumnIndex <- 1, .fontSize <- 12, .textColor <- UIColor.gray)
                ],
                Label(.text <- "这是一条通知消息", .fontSize <- 12, .textColor <- UIColor.gray)
            ]
        ]

        return tableView.makeCell(element: element)
    }

    // MARK: - collectionView

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        SpeedLog.print(indexPath)
        let element = StackPanel(.width <- collectionView.frame.width / 4)[
//            ImageView(.image <- "https://www.baidu.com/img/bd_logo1.png",.width <- 50,.height <- 50) ,
            Image(.image <- "icon1", .hAlign <- .Center),
            Label(.text <- "icon", .hAlign <- .Center)
        ]
        return collectionView.makeCell(element: element, indexPath: indexPath)
    }
}
