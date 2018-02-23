//
//  ViewController.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/10.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class GridColumnSplitVC: SafeAreaVC {
//    @IBOutlet var declareLayoutParent: DeclareLayoutView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHostView {
            HostView {
                Grid(.columns <- [.star(1), .auto]) {
                    [
                        Button(.vAlign <- .Center, .hAlign <- .Center, .padding <- Insets(20), .title <- "333"),
                        Label(.text <- "UILabel"),
                        Label(.gridColumnIndex <- 1, .text <- "Label2")
                    ]
                }
            }.with { $0.backgroundColor = .red }
        }
    }

}

class Person {
    var age: CGFloat?
    var name: String?
    var fuck: Int?
    init(age: CGFloat?, name: String?, fuck: Int?) {

    }
}
