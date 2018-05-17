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
                Label { $0.text = "First" },
                Label(.gridRowIndex <- 1) { $0.text = "Middle" },
                Label(.gridRowIndex <- 2) { $0.text = "Last" },
                TextField(.margin <- Insets(8), .gridColumnIndex <- 1) { $0.backgroundColor = .gray },
                TextField(.margin <- Insets(8), .gridRowIndex <- 1, .gridColumnIndex <- 1) { $0.backgroundColor = .gray },
                TextField(.margin <- Insets(8), .gridRowIndex <- 2, .gridColumnIndex <- 1) { $0.backgroundColor = .gray }
            ]
        }
    }
}
