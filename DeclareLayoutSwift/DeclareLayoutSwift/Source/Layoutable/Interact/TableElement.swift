//
//  Table.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/31.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

@objc public protocol TableElementDelegate: NSObjectProtocol {
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UIElement
    
    @objc optional func numberOfSections(in tableView: UITableView) -> Int
    
//    @objc optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    //
//    @objc optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    //
//    @objc optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    //
//    @objc optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    //
//    @objc optional func sectionIndexTitles(for tableView: UITableView) -> [String]?
    //
//    @objc optional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    //
//    @objc optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    //
//    @objc optional func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

public class TableElement: ViewElement<UITableView>, UITableViewDataSource, UITableViewDelegate {
//    private var _dataContext: Any?
//    var dataContext: Any {
//        get {
//            return ""
//        }
//        set {
//            _dataContext = newValue
//        }
//    }
    
    var delegate: TableElementDelegate?
    
//    var elementOfIndexPath: Dictionary<IndexPath, UIElement> = [:]
    var heightForRows: Dictionary<IndexPath, CGFloat> = [:]
    
//    override init(view: UITableView) {
//        super.init(view: view)
    //
//        view.dataSource = self
//        view.delegate = self
//    }
    
    public convenience init(_ propertySetters: PropertySetter<TableElement>...) {
        self.init()
        
        view.dataSource = self
        view.delegate = self
        propertySetters.forEach { $0.setter(self) }
    }
    
    // MARK: - table view data source
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let delegate = delegate {
            return delegate.tableView(tableView, numberOfRowsInSection: section)
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let contentView = cell.contentView
        
        if let delegate = delegate {
            let element = delegate.tableView(tableView, cellForRowAt: indexPath)
            element.setup()
            element.measure(DLSize(width: tableView.frame.width, height: CGFloat.nan))
            element.hostView = contentView
//            elementOfIndexPath[indexPath] = element
//            let ele = elementOfIndexPath[indexPath]
            let separatorHeight: CGFloat = 0.334
            let elementHeight = element.desiredSize.height
            let cellHeight = tableView.separatorStyle == .none ? elementHeight : elementHeight + separatorHeight
            heightForRows[indexPath] = cellHeight
            element.arrange(CGRect(x: 0, y: 0, width: tableView.frame.width, height: elementHeight))
        }
        
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let imp = delegate?.numberOfSections {
            return imp(tableView)
        } else {
            return 1
        }
    }
    
    // MARK: - 333
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let ele = elementOfIndexPath[indexPath]
//        let separatorHeight: CGFloat = 0.334
//        let elementHeight = ele!.desiredSize.height
//        return tableView.separatorStyle == .none ? elementHeight : elementHeight + separatorHeight
        return heightForRows[indexPath]!
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let ele = elementOfIndexPath[indexPath]
//        ele!.arrange(cell.contentView.bounds)
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
    }
    
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
    }
    
}

// class ItemTemplate{
//    let element:UIElement
//    var bindings:[Binding]?
//    init(element:UIElement) {
//        self.element = element
//    }
//
//    func setBinding(data:NSObject?){
//        if let bindings = bindings,let data=data{
//            for binding in bindings {
//                binding.source = data
//                binding.setBinding()
//            }
//        }
//    }
// }
//
// class Table:SelfPaddingViewElement<UITableView>,UITableViewDataSource,UITableViewDelegate{
//
//
//    override var padding: UIEdgeInsets?{
//        get{
//            return view.contentInset
//        }
//        set{
//            view.contentInset = padding ?? UIEdgeInsets.zero
//        }
//    }
//
//    var itemTemplates:[ItemTemplate]
//
//    init(itemTemplates:[ItemTemplate]) {
//
//        self.itemTemplates = itemTemplates
//        super.init()
//
//        self.view.dataSource = self
//        self.view.delegate = self
//    }
//
////    var items:[Any]?
//
//    func getElement()-> UIElement{
//        let grid = Grid()
//        grid.columns = [.Star(star: 1, min: nil, max: nil),.Auto(min: nil, max: nil)]
//
//        let label = ViewElement<UILabel>()
//        label.view.text = "开始做题"
//        Grid.setColumn(ele: label, column: 1)
//        grid.children.append(label)
//
//
//        let nameLabel = ViewElement<UILabel>()
//        nameLabel.view.text = "name"
//        let desLabel = ViewElement<UILabel>()
//        desLabel.view.text = "jjjjjjjjjjjjjjj"
//
//        let stackPanel = StackPanel()
//        stackPanel.children.append(nameLabel)
//        stackPanel.children.append(desLabel)
//
//        grid.children.append(stackPanel)
//
//        return grid
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        let contentView = cell.contentView
//
//        let hostView = DeclareLayoutView()
//        contentView.addSubview(hostView)
//        hostView.topAnchor.constraint(equalTo: contentView.topAnchor)
//        hostView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        hostView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
//        hostView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
//        hostView.loadUIElement(ele: getElement())
//        contentView.setNeedsLayout()
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
////        let hostView = cell.contentView.subviews.first as! DeclareLayoutView
////        hostView.layoutElements()
//    }
// }
