//
//  UniformGridVC.swift
//  Demo
//
//  Created by 黄周鸿 on 2018/3/22.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class UniformGridVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.hostElement {
            UniformGrid(columnCount: 3)[
                Label(.text <- "11111", .bgColor <- UIColor.red),
                Label(.text <- "22222222222222222222222222", .bgColor <- UIColor.green),
                Label(.text <- "33333333333333333333333333", .bgColor <- UIColor.blue),
                Label(.text <- "44444444444444444444444444", .bgColor <- UIColor.yellow)
            ]
        }
    }
}
