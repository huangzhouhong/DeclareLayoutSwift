//
//  GridVC.swift
//  Demo
//
//  Created by 黄周鸿 on 2018/3/22.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class GridVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.hostElement {
            Grid(.rows <- [.auto, .auto, .auto], .columns <- [.auto, .star(1)])[
                Label(.text <- "First"),
                Label(.text <- "Middle", .gridRowIndex <- 1),
                Label(.text <- "Last", .gridRowIndex <- 2),
                TextField(.margin <- Insets(8), .gridColumnIndex <- 1, .bgColor <- UIColor.gray),
                TextField(.margin <- Insets(8), .gridRowIndex <- 1, .gridColumnIndex <- 1, .bgColor <- UIColor.gray),
                TextField(.margin <- Insets(8), .gridRowIndex <- 2, .gridColumnIndex <- 1, .bgColor <- UIColor.gray)
            ]
        }
    }
}
