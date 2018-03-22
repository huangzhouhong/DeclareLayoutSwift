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

class GridSelectVC: UITableViewController {

//    let names=["GridColumnSplitVC" , "GridMixVC","StackVC","GridNestedVC"]
    var names: [UIViewController.Type] = []

    fileprivate func findAllVC() {
        var count: UInt32 = 0
        let classList = objc_copyClassList(&count)!

        for i in 0..<Int(count) {
            let cls: AnyClass = classList[i]
            if class_getSuperclass(cls) == UIViewController.self {
                self.names.append(cls as! UIViewController.Type)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.findAllVC()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = String(describing: names[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = self.names[indexPath.row]
        let vc = name.init()
        vc.title = String(describing: names[indexPath.row])

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
