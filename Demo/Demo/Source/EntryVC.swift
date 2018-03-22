//
//  EntryVC.swift
//  Demo
//
//  Created by 黄周鸿 on 2018/3/22.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

struct EntryCategory {
    var title: String
    var entrys: [Entry]
}

struct Entry {
    var vc: UIViewController.Type
    var title: String
    var description: String
}

class EntryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let categorys: [EntryCategory]
        = [EntryCategory(title: "Panels Usage", entrys:
               [Entry(vc: StackPanelVC.self, title: "StackPanel", description: "a vertical StackPanel.\nStackPanel support vertical and horizontal layout"),
                Entry(vc: GridVC.self, title: "Grid", description: "Grid Defines a flexible grid area that consists of columns and rows, and split space like a table.Rows and columns can be auto(fit children content),fixed(explicit value),and star(Split by proportion)"),
                Entry(vc: UniformGridVC.self, title: "UniformGrid", description: "Split into the same size cells")]),
        EntryCategory(title: "Table Simples", entrys:
            [Entry(vc: TableVC.self, title: "Simple Table 1", description: "No need to return cell height,just host element in cell(use `UITableView.makeCell`).Apple's auto sizing will work"),
             Entry(vc: QQMsgVC.self, title: "Simple Table 2", description: "same"),
             Entry(vc: EntryVC.self, title: "Table with section header", description: "Provide a `HostView` that host `UIElement`,height is automatic calulate."),
             Entry(vc: ClassMainVC.self, title: "Items", description: "666")])]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.hostElement {
            Table(.delegate <- self, .dataSource <- self) {
                UITableView(frame: CGRect.zero, style: .grouped)
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return categorys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorys[section].entrys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = categorys[indexPath.section].entrys[indexPath.row]
        let grayFontColor = UIColor(rgbValue: 0x999999)
        let element = StackPanel(.margin <- Insets(vertical: 8, horizontal: 20)) {
            [Label(.text <- entry.title),
             Label(.text <- "Will show:\(entry.vc)", .fontSize <- 13, .textColor <- grayFontColor),
             View(.height <- 0.5, .bgColor <- .gray),
             Label(.text <- "Description:\(entry.description)", .numberOfLines <- 0, .fontSize <- 13, .textColor <- grayFontColor)]
        }

        return tableView.makeCell(element: element)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = categorys[section].title
        return HostView {
            StackPanel(.orientation <- .Horizontal) {
                [Image(.image <- "icon1",.margin <- Insets(8)),
                 Label(.text <- title)]
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let entry = categorys[indexPath.section].entrys[indexPath.row]
        let vc = entry.vc.init()
        vc.title = entry.title
        navigationController?.pushViewController(vc, animated: true)
    }
}
