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

        view.backgroundColor = .white
        view.hostElement {
            StackPanel()[
                Image(.hAlign <- .Center) { $0.image = #imageLiteral(resourceName: "icon1") },
                Label(.hAlign <- .Center) { $0.text = "Name" }
            ]
        }
    }
}
