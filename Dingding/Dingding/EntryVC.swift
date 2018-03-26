//
//  GridSelectVC.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/17.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import ObjectiveC
import UIKit

// show all View Controller in this Project
class EntryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let names: [UIViewController.Type] = [MainVC.self]
//    var names: [UIViewController.Type] = []

//    fileprivate func findAllVC() {
//        var count: UInt32 = 0
//        let classList = objc_copyClassList(&count)!
    //
//        for i in 0..<Int(count) {
//            let cls: AnyClass = classList[i]
//            if class_getSuperclass(cls) == UIViewController.self && cls != EntryVC.self {
//                self.names.append(cls as! UIViewController.Type)
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Entry"
        self.view.hostElement {
            Table(.delegate <- self, .dataSource <- self)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = String(describing: names[indexPath.row])
        return tableView.makeCell(element: Label(.text <- name, .margin <- Insets(vertical: 10, horizontal: 20)))
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = self.names[indexPath.row]
        let vc = name.init()
        vc.title = String(describing: names[indexPath.row])

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
