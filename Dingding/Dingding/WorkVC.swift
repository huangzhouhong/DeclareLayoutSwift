//
//  WorkVC.swift
//  Dingding
//
//  Created by 黄周鸿 on 2018/3/24.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import DeclareLayoutSwift
import UIKit

enum WorkCellType: Int {
    case app, otherApp
    static var count: Int { return WorkCellType.otherApp.rawValue + 1 }
}

typealias WorkIcon = (image: String, name: String)

class WorkItemsDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var model: [WorkIcon]
    init(model: [WorkIcon]) {
        self.model = model
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = model[indexPath.row]
        let itemWidth = floor(collectionView.frame.width / 3)
        let element = StackPanel(.width <- itemWidth) {
            [Image(.image <- data.image, .hAlign <- .Center),
             Label(.text <- data.name, .hAlign <- .Center, .margin <- Insets(top: 4), .fontSize <- 14)]
        }
        return collectionView.makeCell(element: element, indexPath: indexPath)
    }
}

class WorkHeaderDelegate: NSObject, PagesDelegate {
    var model: [WorkIcon]
    let eachPageItemCount = 3
    init(model: [WorkIcon]) {
        self.model = model
    }
    
    func pagesCellForItemAt(_ index: Int) -> UIElement {
        let pageModelStartIndex = index * eachPageItemCount
        let pageModelEndIndex = min((index + 1) * eachPageItemCount, model.count) - 1
        let pageModel = model[pageModelStartIndex ... pageModelEndIndex]
        let pageDelegate = WorkItemsDelegate(model: [WorkIcon](pageModel))
        
        let element = Items(.dataSource <- pageDelegate, .itemMinHSpacing <- 0, .bgColor <- .white)
        // retain pageDelegate until element release
        element.setValue(key: "pageDelegate", value: pageDelegate)
        return element
    }
    
    func pageNumberOfItems() -> Int {
        return Int(ceil(Double(self.model.count) / Double(self.eachPageItemCount)))
    }
}

class WorkVC: UIViewController, UITableViewDataSource {
    var appDelegate: WorkItemsDelegate?
    var otherDelegate: WorkItemsDelegate?
    var headerDelegate: WorkHeaderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupModel()
        
        self.createTitleView(title: "XXX有限工司")
        
        self.view.hostElement {
            Table(.dataSource <- self, .margin <- Insets(vertical: 0, horizontal: 12), .header <- createHeader())
        }
    }
    
    func setupModel() {
        let appModel: [WorkIcon] = [("Work_icon", "考勤打卡"), ("Work_icon", "审批"), ("Work_icon", "日志"), ("Work_icon", "签到"), ("Work_icon", "智能报表"), ("Work_icon", "公告"), ("Work_icon", "钉盘"), ("Work_icon", "客户管理")]
        self.appDelegate = WorkItemsDelegate(model: appModel)
        
        let otherModel: [WorkIcon] = [("Work_icon", "钉钉运动"), ("Work_icon", "全部")]
        self.otherDelegate = WorkItemsDelegate(model: otherModel)
        
        let headerModel = [("Work_icon", "待我审批"), ("Work_icon", "出勤天数"), ("Work_icon", "请假"), ("Work_icon", "日报")]
        headerDelegate = WorkHeaderDelegate(model: headerModel)
    }
    
    func createHeader() -> UIElement {
        let pageControl = PageControl()
        pageControl.view.currentPageIndicatorTintColor = UIColor(rgbValue: 0xA4A4A6)
        pageControl.view.pageIndicatorTintColor = UIColor(rgbValue: 0xE4E4E4)
        return StackPanel {
            [Image(.image <- #imageLiteral(resourceName: "Work_Banner")),
             Pages(.pagesDelegate <- self.headerDelegate!, .pageControl <- pageControl),
             pageControl,
             View(.bgColor <- UIColor(rgbValue: 0xFFC8C7CC), .height <- 0.5)]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorkCellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTitle: String
        let workDelegate: WorkItemsDelegate
        let cellType = WorkCellType(rawValue: indexPath.row)!
        switch cellType {
        case .app:
            cellTitle = "常用应用"
            workDelegate = self.appDelegate!
        default:
            cellTitle = "其他应用"
            workDelegate = self.otherDelegate!
        }
        
        let element = StackPanel(.margin <- Insets(top: 20)) {
            [Label(.text <- cellTitle),
             Items(.delegate <- workDelegate, .dataSource <- workDelegate, .bgColor <- .white, .itemMinHSpacing <- 0, .margin <- Insets(vertical: 10, horizontal: 0))]
        }
        
        return tableView.makeCell(element: element)
    }
}
