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
        
        self.hostElement {
            StackPanel {
                [TextField(.bgColor <- .gray, .textColor <- .white, .padding <- Insets(vertical: 8, horizontal: 15), .margin <- Insets(8), .editingChanged <- #selector(self.onEditingChanged(sender:))),
                 Label().outlet(&self.label),
                 Button(.title <- "Tap Me", .textColor <- .blue, .touchDown <- #selector(self.onTapButton))]
            }
        }
    }
    
    @objc func onEditingChanged(sender: UITextField) {
        self.label.view.text = sender.text
        self.label.hostView?.setNeedsLayout()
    }
    
    @objc func onTapButton() {
        let alert = UIAlertController(title: nil, message: "You tap", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
