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
                Label {
                    $0.text = "11111"
                    $0.backgroundColor = .red
                },
                Label {
                    $0.text = "22222222222222222222222222"
                    $0.backgroundColor = .green
                },
                Label {
                    $0.text = "33333333333333333333333333"
                    $0.backgroundColor = .blue
                },
                Label {
                    $0.text = "44444444444444444444444444"
                    $0.backgroundColor = .yellow
                }
            ]
        }
    }
}
