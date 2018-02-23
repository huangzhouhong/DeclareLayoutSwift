//
//  TestViewControllerBase.swift
//  DeclareLayoutSwift
//
//  Created by 黄周鸿 on 2018/1/1.
//  Copyright © 2018年 com.yasoon. All rights reserved.
//

import UIKit

open class SafeAreaVC: UIViewController {
//    var hostView:DeclareLayoutView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func setupHostView(createHost:()->HostView){
        self.hostView=createHost()
        
        self.view.addSubview(hostView)
        self.view.backgroundColor = .white
        
        let margin = self.view.safeAreaLayoutGuide
        hostView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        hostView.leftAnchor.constraint(equalTo: margin.leftAnchor).isActive = true
        hostView.rightAnchor.constraint(equalTo: margin.rightAnchor).isActive = true
        hostView.bottomAnchor.constraint(equalTo: margin.bottomAnchor).isActive = true
        hostView.translatesAutoresizingMaskIntoConstraints = false
        
//        hostView.backgroundColor = .white
    }
    
    
    
    var hostView:HostView!
}
