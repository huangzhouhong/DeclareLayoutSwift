//
//  TableCellHost.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/3/21.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

class UITableViewCellStore :NSObject {
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

extension UITableViewCell {
    private var store: UITableViewCellStore {
        return getExtStore()
    }
    
    public var element: UIElement? {
        set {
            store.element = newValue
        }
        get {
            return store.element
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

extension UITableView {
    public func makeCell(element: UIElement, accessoryType: UITableViewCellAccessoryType = .none) -> UITableViewCell {
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
}
