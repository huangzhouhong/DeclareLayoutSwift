//
//  ClassMainVC.swift
//  Demo
//
//  Created by 黄周鸿 on 2018/2/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class ClassMainVC: SafeAreaVC, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PagesDelegate {
    var table: Table!
    let images = ["banner1", "banner2", "banner3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRootElement {
            Table(.delegate <- self, .dataSource <- self).outlet(&table)
        }

        table.header = StackPanel {
            [Pages(.height <- 180, .pagesDelegate <- self, .scrollDuration <- TimeInterval(2.0), .loop <- true),
             Items(.delegate <- self, .dataSource <- self, .bgColor <- .white, .height <- 300),
             ViewElement(.bgColor <- UIColor(rgbValue: 0xf0f0f0), .height <- 8)]
        }
    }

    // MARK: - PagesDelegate

    func pagesCellForItemAt(_ index: Int) -> UIElement {
        return Image(.image <- images[index])
    }

    func pageNumberOfItems() -> Int {
        return images.count
    }

    // MARK: - tableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let redDotSize: CGFloat = 6

        let showDot = indexPath.row % 2 == 0
        let visibility: Visibility = showDot ? .Visible : .Hidden

        let element = Grid(.columns <- [.auto(), .star(1)], .margin <- Insets(8)) {
            [View(.bgColor <- .red, .cornerRadius <- redDotSize / 2, .width <- redDotSize, .height <- redDotSize, .vAlign <- .Center, .margin <- Insets(10), .visibility <- visibility),
             StackPanel(.gridColumnIndex <- 1) {
                 [Grid(.columns <- [.star(1), .auto]) {
                     [Label(.text <- "今天", .fontSize <- 16, .margin <- Insets(bottom: 4)),
                      Label(.text <- "2018-01-01", .gridColumnIndex <- 1, .fontSize <- 12, .textColor <- .gray)]
                 },
                  Label(.text <- "这是一条通知消息", .fontSize <- 12, .textColor <- .gray)]
            }]
        }

        return tableView.makeCell(element: element, indexPath: indexPath)
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.heightForIndexPath(indexPath)
//    }

    // MARK: - collectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = StackPanel {
//            ImageView(.image <- "https://www.baidu.com/img/bd_logo1.png",.width <- 50,.height <- 50) &
            Image(.image <- "osx") &
                Label(.text <- "icon", .hAlign <- .Center)
        }
        return collectionView.makeCell(element: element, indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.sizeForItem(indexPath)
    }
}
