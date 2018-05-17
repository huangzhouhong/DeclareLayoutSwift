//
//  File.swift
//  Demo
//
//  Created by 黄周鸿 on 2018/4/6.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class ControlEventVC: UIViewController {
    weak var label: Label!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        hostElement {
            StackPanel()[
                TextField(.padding <- Insets(vertical: 8, horizontal: 15), .margin <- Insets(8)) {
                    $0.backgroundColor = .gray
                    $0.textColor = .white
                    $0.addTarget(self, action: #selector(self.onEditingChanged(sender:)), for: .touchUpInside)
                },
                Label().outlet(&self.label),
                Button {
                    $0.setTitle("Tap Me", for: .normal)
                    $0.setTitleColor(.blue, for: .normal)
                    $0.addTarget(self, action: #selector(self.onTapButton), for: .touchUpInside)
                }
            ]
        }
    }

    @objc func onEditingChanged(sender: UITextField) {
        label.view.text = sender.text
        label.hostView?.setNeedsLayout()
    }

    @objc func onTapButton() {
        let alert = UIAlertController(title: nil, message: "You tap", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
