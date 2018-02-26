//
//  ClassMainVC.swift
//  Demo
//
//  Created by 黄周鸿 on 2018/2/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

// public class CollectionElement: ViewElement<UICollectionView> {
//
// }

class ClassMainVC: SafeAreaVC, TableElementDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRootElement {
            TableElement(.delegate <- self)
        }
//        let redDotSize: CGFloat = 6
//        let redDotView = UIView()
//        redDotView.backgroundColor = .red
//        redDotView.layer.cornerRadius = redDotSize / 2
//        redDotView.clipsToBounds = true
//        let redDotElement = ViewElement<UIView>(view: redDotView)
//        redDotElement.height = redDotSize
//        redDotElement.width = redDotSize
//        redDotElement.verticalAlignment = .Center
//        redDotElement.margin = Insets(10)
        //
//        setupRootElement {
//            Grid(.columns <- [.auto(), .star(1)]) {
//                [redDotElement,
//                 Label(.text <- "这是一条通知消息",.gridColumnIndex <- 1)
//                 /*StackPanel(.gridColumnIndex <- 1) {
//                     [Grid(.columns <- [.star(1), .auto]) {
//                         [Label(.text <- "今天"),
//                          Label(.text <- "2018-01-01", .gridColumnIndex <- 1)]
//                     },
//                      Label(.text <- "这是一条通知消息")]
//                }*/]
//            }
//        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UIElement {

        let redDotSize: CGFloat = 6
        let redDotView = UIView()
        redDotView.backgroundColor = .red
        redDotView.layer.cornerRadius = redDotSize / 2
        redDotView.clipsToBounds = true
        let redDotElement = ViewElement<UIView>(view: redDotView)
        redDotElement.height = redDotSize
        redDotElement.width = redDotSize
        redDotElement.verticalAlignment = .Center
        redDotElement.margin = Insets(10)
        
        let showDot = indexPath.row % 2 == 0
        redDotElement.visibility = showDot ? .Visible : .Hidden

        return Grid(.columns <- [.auto(), .star(1)], .margin <- Insets(8)) {
            [redDotElement,
             StackPanel(.gridColumnIndex <- 1) {
                 [Grid(.columns <- [.star(1), .auto]) {
                     [Label(.text <- "今天", .fontSize <- 16, .margin <- Insets(bottom: 4)),
                      Label(.text <- "2018-01-01", .gridColumnIndex <- 1, .fontSize <- 12, .textColor <- .gray)]
                 },
                  Label(.text <- "这是一条通知消息", .fontSize <- 12, .textColor <- .gray)]
            }]
        }

//        let text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//        let randomIndex = arc4random_uniform(UInt32(text.count))
//        let index = text.index(text.startIndex, offsetBy: Int(randomIndex))
//        let randString: String = String(text[...index])
        //
//        return Grid(.columns <- [.auto(min: 50), .star(1)], .padding <- Insets(vertical: 8, horizontal: 20)) {
//            [Label(.text <- String(indexPath.row)),
//             Label(.gridColumnIndex <- 1, .text <- randString, .numberOfLines <- 0)]
//        }
    }

}
