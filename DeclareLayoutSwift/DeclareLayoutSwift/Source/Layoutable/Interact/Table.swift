//
//  Table.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2017/12/31.
//  Copyright © 2017年 com.yasoon. All rights reserved.
//

import UIKit

class UITableViewCellStore {
    var element: UIElement?
    weak var tableView: UITableView?
    
    static var DisclosureIndicatorWidth: CGFloat = {
        _getRightWidth(accessoryType: .disclosureIndicator)
    }()
    static var DetailDisclosureButtonWidth: CGFloat = {
        _getRightWidth(accessoryType: .detailDisclosureButton)
    }()
    static var CheckmarkWidth: CGFloat = {
        _getRightWidth(accessoryType: .checkmark)
    }()
    static var detailButtonWidth: CGFloat = {
        _getRightWidth(accessoryType: .detailButton)
    }()
    
    static func getRightWidth(accessoryType: UITableViewCellAccessoryType) -> CGFloat {
        switch accessoryType {
        case .none:
            return 0
        case .checkmark:
            return self.CheckmarkWidth
        case .detailButton:
            return self.detailButtonWidth
        case .detailDisclosureButton:
            return self.DetailDisclosureButtonWidth
        case .disclosureIndicator:
            return self.DisclosureIndicatorWidth
        }
    }
    
    private static func _getRightWidth(accessoryType: UITableViewCellAccessoryType) -> CGFloat {
        let cell = UITableViewCell()
        cell.accessoryType = accessoryType
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        print("cell:\(cell.frame),contentView:\(cell.contentView.frame)")
        return cell.frame.width - cell.contentView.frame.width
    }
}

extension UITableViewCell: SupportStoreProperty {
    struct PropertyNames {
        static var store = "store"
    }
    private var store: UITableViewCellStore {
        if let s = getValue(key: &PropertyNames.store) as? UITableViewCellStore {
            return s
        } else {
            let s = UITableViewCellStore()
            setValue(key: &PropertyNames.store, value: s)
            return s
        }
    }
    
    public var element: UIElement? {
        set {
            self.store.element = newValue
        }
        get {
            return self.store.element
        }
    }
    
    public var tableView: UITableView? {
        set {
            store.tableView = newValue
        }
        get {
            return store.tableView
        }
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let element = self.element, let tableView = self.tableView else {
            return super.sizeThatFits(size)
        }
        
        let contentViewRenderWidth = size.width - UITableViewCellStore.getRightWidth(accessoryType: accessoryType)
        
        element.setup()
        element.measure(DLSize(width: contentViewRenderWidth, height: CGFloat.nan))
        element.hostView = contentView
        let elementHeight = element.desiredSize.height
        element.arrange(CGRect(x: 0, y: 0, width: contentViewRenderWidth, height: elementHeight))
        
        let separatorHeight: CGFloat = 0.5
        let cellHeight = tableView.separatorStyle == .none ? elementHeight : elementHeight + separatorHeight
        return CGSize(width: size.width, height: cellHeight)
    }
}

// class UITableViewStore: NSObject {
//    var heightForRows: Dictionary<IndexPath, CGFloat> = [:]
//    var lastTableViewWidth: CGFloat = 0
//
//    static var DisclosureIndicatorWidth: CGFloat = {
//        _getRightWidth(accessoryType: .disclosureIndicator)
//    }()
//    static var DetailDisclosureButtonWidth: CGFloat = {
//        _getRightWidth(accessoryType: .detailDisclosureButton)
//    }()
//    static var CheckmarkWidth: CGFloat = {
//        _getRightWidth(accessoryType: .checkmark)
//    }()
//    static var detailButtonWidth: CGFloat = {
//        _getRightWidth(accessoryType: .detailButton)
//    }()
//
//    static func getRightWidth(accessoryType: UITableViewCellAccessoryType) -> CGFloat {
//        switch accessoryType {
//        case .none:
//            return 0
//        case .checkmark:
//            return self.CheckmarkWidth
//        case .detailButton:
//            return self.detailButtonWidth
//        case .detailDisclosureButton:
//            return self.DetailDisclosureButtonWidth
//        case .disclosureIndicator:
//            return self.DisclosureIndicatorWidth
//        }
//    }
//
//    private static func _getRightWidth(accessoryType: UITableViewCellAccessoryType) -> CGFloat {
//        let cell = UITableViewCell()
//        cell.accessoryType = accessoryType
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
//        print("cell:\(cell.frame),contentView:\(cell.contentView.frame)")
//        return cell.frame.width - cell.contentView.frame.width
//    }
// }

extension UITableView: SupportStoreProperty {
//    struct PropertyNames {
//        static var store = "store"
//    }
//    private var store: UITableViewStore {
//        if let s = getValue(key: &PropertyNames.store) as? UITableViewStore {
//            return s
//        } else {
//            let s = UITableViewStore()
//            setValue(key: &PropertyNames.store, value: s)
//            return s
//        }
//    }
    
//    private func compareTableViewWidth() -> Bool {
    //
//    }
    
//    private func getContentViewRenderWidth(accessoryType: UITableViewCellAccessoryType) -> CGFloat {
//        return frame.width - UITableViewStore.getRightWidth(accessoryType: accessoryType)
//    }
    
    public func makeCell(element: UIElement, indexPath: IndexPath, accessoryType: UITableViewCellAccessoryType = .none) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = accessoryType
//        host(element: element, inCell: cell, indexPath: indexPath)
        cell.element = element
        cell.tableView = self
        
        return cell
    }
    
    // you provide cell.
    // e.g. `dequeueReusableCell(withIdentifier:for:)`
    public func host(element: UIElement, inCell cell: UITableViewCell) {
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.element = element
        cell.tableView = self
    }
    
//    public func host(element: UIElement, inCell cell: UITableViewCell, indexPath: IndexPath) {
//        let contentView = cell.contentView
//        let hostView = TableCellHostView(element: element)
//        contentView.addSubview(hostView)
    //
//        let margin = contentView
//        hostView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
//        hostView.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
//        hostView.rightAnchor.constraint(equalTo: margin.rightAnchor).isActive = true
//        hostView.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
//        hostView.translatesAutoresizingMaskIntoConstraints = false
    //
    ////        let contentView = cell.contentView
    ////        let contentViewRenderWidth = getContentViewRenderWidth(accessoryType: cell.accessoryType)
    ////
    ////        element.setup()
    ////        element.measure(DLSize(width: contentViewRenderWidth, height: CGFloat.nan))
    ////        element.hostView = contentView
    ////        let elementHeight = element.desiredSize.height
    ////        element.arrange(CGRect(x: 0, y: 0, width: contentViewRenderWidth, height: elementHeight))
    ////
    //////        self.store.lastTableViewWidth = frame.width
    ////
    ////        let separatorHeight: CGFloat = 0.5
    ////        let cellHeight = separatorStyle == .none ? elementHeight : elementHeight + separatorHeight
    ////        store.heightForRows[indexPath] = cellHeight
//    }
    
//    public func heightForIndexPath(_ indexPath: IndexPath) -> CGFloat {
//        // rotated
    ////        if self.store.lastTableViewWidth != frame.width {
    ////            self.store.heightForRows.removeAll()
    ////            self.reloadData()
    ////            return 0
    ////        }
//        return self.store.heightForRows[indexPath]!
//    }
}

public class Table: ViewElement<UITableView> {
    public var header: UIElement? {
        didSet {
            self.createTableHeaderView(width: self.view.frame.width)
        }
    }
    
    func createTableHeaderView(width: CGFloat) {
        if let header = header {
            let headerView = UIView()
            header.setup()
            header.measure(DLSize(width: width, height: CGFloat.nan))
            header.hostView = headerView
            let rect = CGRect(x: 0, y: 0, width: width, height: header.desiredSize.height)
            header.arrange(rect)
            headerView.frame = rect
            self.view.tableHeaderView = headerView
        }
    }
    
    override func arrangeOverwrite(rect: CGRect, innerRect: CGRect) {
        super.arrangeOverwrite(rect: rect, innerRect: innerRect)
        self.createTableHeaderView(width: rect.width)
    }
    
//    public init(_ propertySetters: PropertySetter<ViewElement<UITableView>>...) {
//        super.init(view:UITableView())
//        propertySetters.forEach { $0.setter(self) }
//    }
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
