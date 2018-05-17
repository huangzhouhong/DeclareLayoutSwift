//
//  WorkVC.swift
//  Dingding
//
//  Created by 黄周鸿 on 2018/3/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

class WorkVC: UIViewController, UITableViewDataSource {
    var appDelegate: WorkItemsDelegate?
    var otherDelegate: WorkItemsDelegate?
    var headerDelegate: WorkItemsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupModel()

        let titleButtons = [
            Button(.margin <- Insets(right: 20)) {
                $0.setImage(#imageLiteral(resourceName: "Msg_nav2"), for: .normal)
                $0.addTarget(self, action: #selector(self.onTap), for: .touchUpInside)
            },
            Button {
                $0.setImage(#imageLiteral(resourceName: "Msg_nav3"), for: .normal)
                $0.addTarget(self, action: #selector(self.onTap), for: .touchUpInside)
            }
        ]

        createTitleView(title: "XXX有限工司", buttons: titleButtons)

        view.hostElement {
            Table(.margin <- Insets(vertical: 0, horizontal: 12)) {
                $0.showsVerticalScrollIndicator = false
                $0.dataSource = self
                $1.header = self.createHeader()
            }
        }
    }

    func setupModel() {
        let appModel: [WorkIcon] = [("Work_icon", "考勤打卡"), ("Work_icon", "审批"), ("Work_icon", "日志"), ("Work_icon", "签到"), ("Work_icon", "智能报表"), ("Work_icon", "公告"), ("Work_icon", "钉盘"), ("Work_icon", "客户管理")]
        appDelegate = WorkItemsDelegate(model: appModel)

        let otherModel: [WorkIcon] = [("Work_icon", "钉钉运动"), ("Work_icon", "全部")]
        otherDelegate = WorkItemsDelegate(model: otherModel)

        let headerModel = [("Work_icon", "待我审批"), ("Work_icon", "出勤天数"), ("Work_icon", "请假"), ("Work_icon", "日报")]
        headerDelegate = WorkItemsDelegate(model: headerModel)
    }

    func createHeader() -> UIElement {
        let pageControl = PageControl()
        pageControl.view.currentPageIndicatorTintColor = UIColor(0xA4A4A6)
        pageControl.view.pageIndicatorTintColor = UIColor(0xE4E4E4)

        return StackPanel()[
            Image { $0.image = #imageLiteral(resourceName: "Work_Banner") },
            Items {
                let collectionView = UICollectionViewFactory.createUniformPaging(eachPageColumnCount: 3, pageControl: pageControl.view)
                collectionView.dataSource = headerDelegate
                return collectionView
            },
            pageControl,
            View(.height <- 0.5) { $0.backgroundColor = UIColor("#FFC8C7CC") }
        ]
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return WorkCellType.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTitle: String
        let workDelegate: WorkItemsDelegate
        let cellType = WorkCellType(rawValue: indexPath.row)!
        switch cellType {
        case .app:
            cellTitle = "常用应用"
            workDelegate = appDelegate!
        default:
            cellTitle = "其他应用"
            workDelegate = otherDelegate!
        }

        let element = StackPanel(.margin <- Insets(top: 20))[
            Label { $0.text = cellTitle },
            Items(.margin <- Insets(vertical: 10, horizontal: 0)) {
                let collectionView = UICollectionViewFactory.createUniform(columnCount: 3)
                collectionView.delegate = workDelegate
                collectionView.dataSource = workDelegate
                return collectionView
            }
        ]

        return tableView.makeCell(element: element)
    }

    @objc func onTap() {
        SpeedLog.print("ok")
    }
}
