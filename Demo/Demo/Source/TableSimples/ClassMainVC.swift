//
//  ClassMainVC.swift
//  Demo
//
//  Created by 黄周鸿 on 2018/2/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class ClassMainBannerDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    let images = ["banner1", "banner2", "banner3"]
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        SpeedLog.print("ClassMainBannerDelegate:\(indexPath)")
        let element = Image { $0.image = UIImage(named: self.images[indexPath.row]) }
        return collectionView.makeCell(element: element, indexPath: indexPath)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SpeedLog.print(indexPath)
    }
}

class ClassMainVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    weak var table: Table!
    let images = ["banner1", "banner2", "banner3"]
    var banner: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.hostElement {
            Table {
                $0.delegate = self
                $0.dataSource = self
            }.outlet(&table)
        }

        table.header = StackPanel()[
            Items {
                let delegate = UICollectionViewInfiniteLoopHook(strongHook:ClassMainBannerDelegate())

                let collectionView = UICollectionViewFactory.createPage()
                let autoScrollController = AutoScrollController(collectionView: collectionView)
                autoScrollController.retain(owner: collectionView)

                collectionView.dataSource = delegate
                collectionView.delegate = delegate
                delegate.retain(owner: collectionView)
                banner = collectionView
                return collectionView
            },
            Items(.margin <- Insets(vertical: 10, horizontal: 20)) {
                $0.delegate = self
                $0.dataSource = self
                $0.backgroundColor = .white
                if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.minimumInteritemSpacing = 0
                }
            },
            View(.height <- 8) {
                $0.backgroundColor = UIColor(0xF0F0F0)
            }
        ]
    }

    // MARK: - tableView

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let redDotSize: CGFloat = 6

        let showDot = indexPath.row % 2 == 0
        let visibility: Visibility = showDot ? .Visible : .Hidden

        let element = LinearGrid(.columns <- [.auto(), .star(1)], .margin <- Insets(8))[
            View(.width <- redDotSize, .height <- redDotSize, .vAlign <- .Center, .margin <- Insets(10), .visibility <- visibility) {
                $0.backgroundColor = .red
                $0.layer.cornerRadius = redDotSize / 2
            },
            StackPanel()[
                LinearGrid(.columns <- [.star(1), .auto])[
                    Label(.margin <- Insets(bottom: 4)) {
                        $0.text = "今天"
                        $0.font = UIFont.systemFont(ofSize: 16)
                    },
                    Label {
                        $0.text = "2018-01-01"
                        $0.font = UIFont.systemFont(ofSize: 12)
                        $0.textColor = .gray
                    }
                ],
                Label {
                    $0.text = "这是一条通知消息"
                    $0.font = UIFont.systemFont(ofSize: 12)
                    $0.textColor = .gray
                }
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
            Image(.hAlign <- .Center) { $0.image = #imageLiteral(resourceName: "icon1") },
            Label(.hAlign <- .Center) { $0.text = "icon" }
        ]
        return collectionView.makeCell(element: element, indexPath: indexPath)
    }
}
