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
    var description: String?
}

class EntryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let categorys: [EntryCategory]
        = [
            EntryCategory(title: "Panels Usage", entrys:
                [
                    Entry(vc: StackPanelVC.self, title: "StackPanel", description: "a vertical StackPanel.\nStackPanel support vertical and horizontal layout"),
                    Entry(vc: GridVC.self, title: "Grid", description: "Grid Defines a flexible grid area that consists of columns and rows, and split space like a table.Rows and columns can be auto(fit children content),fixed(explicit value),and star(Split by proportion)"),
                    Entry(vc: UniformGridVC.self, title: "UniformGrid", description: "Split into the same size cells"),
            ]),
            EntryCategory(title: "Table Simples", entrys:
                [
                    Entry(vc: TableVC.self, title: "Simple Table 1", description: "No need to return cell height,just host element in cell(use `UITableView.makeCell`).Apple's auto sizing will work"),
                    Entry(vc: QQMsgVC.self, title: "Simple Table 2", description: "same as above"),
                    Entry(vc: EntryVC.self, title: "Table with section header", description: "Provide a `HostView` that host `UIElement`,header height is automatic calulate."),
                    Entry(vc: ClassMainVC.self, title: "Items", description: nil),
            ]),
            EntryCategory(title: "Event Simples", entrys:
                [Entry(vc: ControlEventVC.self, title: "Control Event Simple", description: nil)]
            ),
        ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.hostElement {
            Table {
                let tableView = UITableView(frame: CGRect.zero, style: .grouped)
                tableView.delegate = self
                tableView.dataSource = self
                return tableView
            }
        }
    }

    func numberOfSections(in _: UITableView) -> Int {
        return categorys.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorys[section].entrys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = categorys[indexPath.section].entrys[indexPath.row]

        let element = StackPanel(.margin <- Insets(vertical: 8, horizontal: 20))[
            Label { $0.text = entry.title },
            Label {
                $0.text = "Will show:\(entry.vc)"
                $0.font = UIFont.systemFont(ofSize: 13)
                $0.textColor = UIColor(0x999999)
            },
            View(.height <- 0.5) { $0.backgroundColor = .gray },
            Label {
                $0.text = "Description:\(entry.description ?? "None")"
                $0.numberOfLines = 0
                $0.font = UIFont.systemFont(ofSize: 13)
                $0.textColor = UIColor(0x999999)
            }
        ]

        return tableView.makeCell(element: element)
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = categorys[section].title
        
        return HostView {
            StackPanel(.orientation <- .Horizontal)[
                Image(.margin <- Insets(8)) { $0.image = #imageLiteral(resourceName: "icon1") },
                Label { $0.text = title }
            ]
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let entry = categorys[indexPath.section].entrys[indexPath.row]
        let cls = entry.vc
        if cls == EntryVC.self {
            let alert = UIAlertController(title: nil, message: "current view controller", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            let vc = entry.vc.init()
            vc.title = entry.title
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
