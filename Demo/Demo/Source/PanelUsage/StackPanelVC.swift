//
//  StackPanelVC.swift
//  Demo
//
//  Created by 黄周鸿 on 2018/3/21.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class StackPanelVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.hostElement {
            StackPanel {
                [Image(.image <- "icon1", .hAlign <- .Center),
                 Label(.text <- "Name", .hAlign <- .Center)]
            }
        }
    }
}
