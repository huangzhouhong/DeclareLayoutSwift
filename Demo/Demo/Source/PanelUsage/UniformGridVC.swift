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

        self.view.backgroundColor = .white
        self.view.hostElement {
            UniformGrid(columnCount: 3) {
                [
                    Label(.text <- "11111", .bgColor <- .red),
                    Label(.text <- "22222222222222222222222222", .bgColor <- .green),
                    Label(.text <- "33333333333333333333333333", .bgColor <- .blue),
                    Label(.text <- "44444444444444444444444444", .bgColor <- .yellow)
                ]
            }
        }
    }
}
